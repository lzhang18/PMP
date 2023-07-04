function [mp_protected, mpi_protected, mp, mpi,dist] = run_protect(L_min,L_attack,ts,skip)

if sum(skip)==0

dist = zeros(length(ts)-L_min,length(ts)-L_min);
for i=1:length(ts)-L_min
dist(i,:) = abs(MASS_V3(ts, ts(i:i+L_min))); disp(i);
end

else


dist = zeros(length(ts)-L_min,length(ts)-L_min);
for i=1:length(ts)-L_min

if skip(i)==0
dist(i,:) = abs(MASS_V3(ts, ts(i:i+L_min))); disp(i);
end
end

end

[mp_protected, mpi_protected, mp, mpi]=mp_index_switch_precompute(L_min,L_attack,ts,dist,skip);
%cur_min(skip)=inf;