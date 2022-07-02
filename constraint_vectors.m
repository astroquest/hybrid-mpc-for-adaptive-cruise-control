%%% This sub-script computes the constraint vectors at each time step, as
%%% they depend on v(k).

beta = [ 
    -V_ref;
    V_ref;
    zeros(Np,1);
    zeros(Np,1); 
    repmat(u_max, Np, 1); 
    repmat(-u_min, Np, 1);
    zeros(Np,1);
    G - L*v(k);
    K - P*v(k);
    K + P*v(k)
];

beta_eq = [ F*v(k); zeros(Np,1) ];