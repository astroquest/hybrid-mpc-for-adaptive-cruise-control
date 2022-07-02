%%% This sub-script computes the reference vector for each time and creates
%%% a supervector for use in the constraint vectors

kT = k*T;

if 0 <= kT && kT <= 3
    v_ref(k) = 0.85*alpha;
elseif 3 < kT && kT <= 9
    v_ref(k) = 1.2*alpha;
elseif 9 < kT && kT <= 15
    v_ref(k) = 1.2*alpha - 1/12*alpha*(kT - 9);
elseif 15 < kT && kT <= 18
    v_ref(k) = 0.7*alpha;
elseif 18 < kT && kT <= 21
    v_ref(k) = 0.7*alpha + 4/15*alpha*(kT - 18);
elseif 21 < kT && kT <= 30
    v_ref(k) = 0.9*alpha;
end

for j=1:Np
    V_ref(j) = v_ref(k);  % populate supervector
end