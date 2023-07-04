load('eog_multiple_scale_example.mat')
L_target = 300;
L_attack = 600;
%[mp_protected, mpi_protected, mp, mpi,dist] = run_protect(L_target,L_attack, testdata,zeros(size(testdata)));
[mp_protected, mpi_protected, mp, mpi] = run_protect_v2(L_target,L_attack,testdata,zeros(size(testdata)));
attack_on_protect = loc_attack(mpi_protected,L_attack,L_target);
attack_on_orig = loc_attack(mpi,L_attack,L_target);

figure 
subplot(3,1,1)

plot(zscore(testdata(attack_on_protect(1,1):attack_on_protect(1,2))))
hold on
plot(zscore(testdata(attack_on_protect(2,1):attack_on_protect(2,2))))
title("Attack on protected MP")


subplot(3,1,2)
plot(zscore(testdata(attack_on_orig(1,1):attack_on_orig(1,2))))
hold on
plot(zscore(testdata(attack_on_orig(2,1):attack_on_orig(2,2))))
title("Attack on unprotected MP")

[mp, mpi] = stompSelf(testdata,600,0.1);

[a,b]=min(mp);
b2 = mpi(b);
L_attack = attack_on_protect(1,2) - attack_on_protect(1,1);

mp_motif = [b b+L_attack ; b2 b2+L_attack];

subplot(3,1,3)

plot(zscore(testdata(mp_motif(1,1):mp_motif(1,2))))
hold on
plot(zscore(testdata(mp_motif(2,1):mp_motif(2,2))))
title("Actual Top-1 Motif of Attack Length")



attack_on_protect = info_attack(mpi_protected,L_attack,L_target);
attack_on_orig = info_attack(mpi,L_attack,L_target);

figure 
subplot(3,1,1)

plot(zscore(testdata(attack_on_protect(1,1):attack_on_protect(1,2))))
hold on
plot(zscore(testdata(attack_on_protect(2,1):attack_on_protect(2,2))))
title("Attack on protected MP")


subplot(3,1,2)
plot(zscore(testdata(attack_on_orig(1,1):attack_on_orig(1,2))))
hold on
plot(zscore(testdata(attack_on_orig(2,1):attack_on_orig(2,2))))
title("Attack on unprotected MP")

[mp, mpi] = stompSelf(testdata,600,0.1);

[a,b]=min(mp);
b2 = mpi(b);
L_attack = attack_on_protect(1,2) - attack_on_protect(1,1);

mp_motif = [b b+L_attack ; b2 b2+L_attack];

subplot(3,1,3)

plot(zscore(testdata(mp_motif(1,1):mp_motif(1,2))))
hold on
plot(zscore(testdata(mp_motif(2,1):mp_motif(2,2))))
title("Actual Top-1 Motif of Attack Length")

