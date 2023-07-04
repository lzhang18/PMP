function [mp_protected, mpi_protected,mp, mpi]=mp_index_switch(L,L_attack,ts,dist,skip)
%Parameters for PMP:
%    L_perm: length of CIB threshold that algorithm performs perturbation
%    P: Attack Length - Target Length
%    T: centroid length of the perturbed CIB

L_perm = 0.9*L;
P = L_attack-L;
T = L/4;

%ranges that contains all the overlapping interval may help attacker infer location
[mp,mpi]=stompSelf(ts,L,0.2);
mp = abs(mp);

%find all CIB in the MP
ms_start = [1; find(abs(diff(mpi))>L)+1];
ms_end = [find(abs(diff(mpi))>L); length(mpi)];
lens_of_CIB = ms_end - ms_start+1;
interval = [ms_start ms_end];


target_interval = interval;


count = 0;
mp_protected = mp;
mpi_protected = mpi;

for k=1:length(target_interval)
    %For each CBI
    
    start = target_interval(k,1);
    ends = target_interval(k,2);
    target_idx = mpi(start);
    idx_remove = target_idx;
    
    T_org = ceil(normrnd(T,5));
    T_org = max(1,T_org);
    
    if(isinf(idx_remove))
        continue
    end
    cur_idx_before = start;
    lens = target_interval(k,2)-target_interval(k,1)+1;
    %if the CIB length is small, skip
    if lens<L_perm
        continue;
    end
    
    %Otherwise start perturbation
    mask_len = ceil(rand*lens);
    
    disp(k)
    %check tail:
    for i=ends+1:min(length(dist),ends+P)
        if(skip(i)==1)
            continue;
        end
        d_mask = dist(i,:);
        mask_idx1_start = max(1,i-P);
        mask_idx1_end = min(length(dist),i+P);
        d_mask(mask_idx1_start:mask_idx1_end)=inf;
        idx_remove(1) = mpi(ends);
        mask_idx2_start = max(1,idx_remove(1)-P);
        mask_idx2_end = min(length(dist),idx_remove(1)+P);
        d_mask(mask_idx2_start:mask_idx2_end)=inf;
        [mp_protected(i), mpi_protected(i)] = min(d_mask);
    end
    
    %check head:
    for i=max(1,start-P):max(1,start-1)
        if(skip(i)==1)
            continue;
        end
        d_mask = dist(i,:);
        mask_idx1_start = max(1,i-P);
        mask_idx1_end = min(length(dist),i+P);
        d_mask(mask_idx1_start:mask_idx1_end)=inf;
        idx_remove(1) = mpi(start);
        mask_idx2_start = max(1,idx_remove(1)-P);
        mask_idx2_end = min(length(dist),idx_remove(1)+P);
        d_mask(mask_idx2_start:mask_idx2_end)=inf;
        [mp_protected(i), mpi_protected(i)] = min(d_mask);
    end
    
    %check interval:
    for i=start:ends
        if(skip(i)==1)
            continue;
        end
        if target_idx ~=start
            target_idx = mpi(i);
        end
        if i>length(ts)-P
            continue;
        end
        d = dist(i,:);
        d(max(1,i-P):min(length(dist),i+P))=inf;
        d2 = d;
        if i-start+1<mask_len
            idx_remove(1) = target_idx;
            for l=1:length(idx_remove)
                d2(max(1,idx_remove(l)-P):min(length(dist),idx_remove(l)+P))=inf;
            end
        else
            target_idx=start;
            count = 0;
            mask_len = ends-start+1;
            T_org = ceil(normrnd(T,5));
            T_org = max(1,T_org);
        end
   
        [mp_protected(i), mpi_protected(i)] = min(d2);     
        diffs=abs(mpi_protected(i)-cur_idx_before);
        
        if diffs>L
            count = 0;
        else
            count = count+1;
            if count>T_org
                disp(i)
                idx_remove = [idx_remove mpi_protected(i)];
                count=0;
            end
        end
        cur_idx_before=mpi_protected(i);
    end
    
end

% fix any loops issue
for i=1:length(mpi_protected)
    if skip(i)==1
        continue
    end
    if(mpi_protected(mpi_protected(i))==i)
        if mp(i)>mp(mpi_protected(i)) && skip(mpi_protected(i))~=1
            disp(i)
            mp(i)=mp(mpi_protected(i));
        end
    end
end
