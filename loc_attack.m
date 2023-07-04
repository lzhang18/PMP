function attack_loc = loc_attack(bx,L_max,L_min)

ms_start = [1; find(abs(diff(bx))>L_max)+1];
ms_end = [find(abs(diff(bx))>L_max); length(bx)];
interval = [ms_start ms_end];
interval = interval(interval(:,1)<(length(bx)-(L_max-L_min)),:);
interval(isinf(bx(interval(:,1))),:)=[];
lens = interval(:,2) - interval(:,1)+1;

[~,idx]=max(lens);

b=interval(idx,1);

[as,bs] = hist(bx(b:b+L_max-L_min),100);

as(bs>b-L_max & bs<b+L_max)=0;

[~, a_idx]=max(as);
q = abs(bx(b:b+L_max-L_min)-bs(a_idx));
[~,bb]=min(q);

c=  max(1,ceil(bs(a_idx))-bb+1);
attack_loc = [b b+L_max-1; c c+L_max-1];
