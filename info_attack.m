function attack_pred = info_attack(bx,L_max,L_min)
edges = 1:100:10000;
for i=1:length(bx)-L_max
    interval = bx(i:i+L_max-L_min-1);
    axs = histcounts(interval,edges);
    p = (axs+1e-5)./sum(axs+1e-5);
    entropy(i)=sum(-p.*log(p));
end

[a,b] = min(entropy);

[as,bs] = hist(bx(b:b+L_max-L_min),100);

as(bs>b-L_max & bs<b+L_max)=0;

[~, a_idx]=max(as);

attack_pred = [b b+L_max-1; ceil(bs(a_idx)) ceil(bs(a_idx))+L_max-1];
