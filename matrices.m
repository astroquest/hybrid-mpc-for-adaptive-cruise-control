    %%% This script defines all the matrices that are constant throughout the
%%% program.

%% state equation

A = 1 - T/m*a_1;
B_1 = T/m * b/(1 + gamma);
B_2 = [ 0, -T/m*b_2, 0 ];
B_3 = T/m * [ b/(1+2*gamma) - b/(1+gamma), ...
    a_1 - a_2, b/(1+3*gamma) - b/(1+2*gamma) ];


%% mld matrices

E_1 = [ 
    -1;
    1; 
    -1; 
    1; 
    -1; 
    1; 
    0; 
    0; 
    0; 
    0; 
    0; 
    0; 
    -1; 
    1; 
    0; 
    0; 
    0; 
    0
];
E_2 = [ 
    0;
    0; 
    0; 
    0; 
    0; 
    0; 
    0; 
    0; 
    -1; 
    1; 
    0; 
    0; 
    0; 
    0; 
    0; 
    0; 
    -1; 
    1
];
E_3 = [
    M_1, 0, 0;
    m_1-eps, 0, 0;
    0, M_2, 0;
    0, m_2-eps, 0;
    0, 0, M_3;
    0, 0, m_3-eps;
    -M_u, 0, 0;
    m_u, 0, 0;
    -m_u, 0, 0;
    M_u, 0, 0;
    0, -M_v, 0;
    0, m_v, 0;
    0, -m_v, 0;
    0, M_v, 0;
    0, 0, -M_u;
    0, 0, m_u;
    0, 0, -m_u;
    0, 0, M_u
];
E_4 = [
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    0, 0, 0;
    1, 0, 0;
    -1, 0, 0;
    1, 0, 0;
    -1, 0, 0;
    0, 1, 0;
    0, -1, 0;
    0, 1, 0;
    0, -1, 0;
    0, 0, 1;
    0, 0, -1;
    0, 0, 1;
    0, 0, -1
];

g_5 = [
    M_1-v_12;
    v_12-eps;
    M_2-alpha;
    alpha-eps;
    M_3-v_23;
    v_23-eps;
    0;
    0;
    -m_u;
    M_u;
    0; 
    0; 
    -m_v; 
    M_v; 
    0; 
    0; 
    -m_u; 
    M_u
];


%% inequality constraints

I = eye(Np);
O = zeros(Np, Np);

S_1 = matrix_S(Np, E_1, A, E_2, B_1);
S_2 = matrix_S(Np, E_1, A, E_3, B_2);
S_3 = matrix_S(Np, E_1, A, E_4, B_3);

Q_1 = matrix_Q(Np, A, B_1);
Q_2 = matrix_Q(Np, A, B_2);
Q_3 = matrix_Q(Np, A, B_3);

G = repmat(g_5, Np, 1);
L = matrix_L(Np, A, E_1);
K = repmat(T*a_comf_max, Np, 1);
P = matrix_P(Np, A);

Phi = [
    -I, O, [O, O, O], [O, O, O], -I, O;     % dual constraint
    I, O, [O, O, O], [O, O, O], -I, O;      % dual constraint
    O, -I, [O, O, O], [O, O, O], O, -I;     % dual constraint
    O, I, [O, O, O], [O, O, O], O, -I;      % dual constraint
    O, I, [O, O, O], [O, O, O], O, O;       % input bound
    O, -I, [O, O, O], [O, O, O], O, O;      % input bound
    -I, O, [O, O, O], [O, O, O], O, O;      % non-negative velocity
    repmat(O,18,1), S_1, S_2, S_3, repmat(O,18,1), repmat(O,18,1);  % mld constraint
    O, Q_1, Q_2, Q_3, O, O;                 % comfort
    O, -Q_1, -Q_2, -Q_3, O, O;              % comfort
];


%% equality constraints

C_1 = matrix_C(Np, A, B_1); 
C_2 = matrix_C(Np, A, B_2);
C_3 = matrix_C(Np, A, B_3);
W = matrix_W(Np, Nc);

F = matrix_F(Np, A);

Phi_eq = [ 
    I -C_1 -C_2 -C_3 O O;
    O W O O O O O O O O;
];


%% functions

function S = matrix_S(Np, E_1, A, E, B)
    V = cell(Np, 1);
    V{1} = E;
    for p=1:Np-1
        V{p+1} = E_1*A^(p-1)*B;
    end

    S = lower_triangular(V);
end

function Q = matrix_Q(Np, A, B)
    V = cell(Np, 1);
    V{1} = B;
    for p=1:Np-1
        V{p+1} = A^(p-1)*(A-1)*B;
    end

    Q = lower_triangular(V);
end

function C = matrix_C(Np, A, B)
    V = cell(Np, 1);
    V{1} = B;
    for p=1:Np-1
        V{p+1} = A^p*B;
    end

    C = lower_triangular(V);
end

function W = matrix_W(Np, Nc)
    W = zeros(Np, Np);
    for p=0:Np-Nc-1
        W(Nc+1+p, Nc) = 1;
        W(Nc+1+p, Nc+p+1) = -1;
    end
end

function L = matrix_L(Np, A, E_1)
    L = zeros(Np*size(E_1, 1), 1);
    q = 1;
    for p=1:Np
        L(q:q+size(E_1, 1)-1) = E_1*A^(p-1);
        q = q + size(E_1, 1);
    end
end

function P = matrix_P(Np, A)
    P = zeros(Np, 1);
    for p=1:Np
        P(p) = A^(p-1)*(A-1);
    end
end

function F = matrix_F(Np, A)
    F = zeros(Np, 1);
    for p=1:Np
        F(p) = A^p;
    end
end

function M = lower_triangular(V)
    % this function scales the size of the matrix for a given Np
    H = numel(V);
    X = tril(true(H));
    Y = hankel(ones(1,H));
    [R,~] = find(Y);
    U = accumarray(R,find(X),[],@(n){n});
    Z = cell(H);
    for k = 1:H
        Z(U{k}) = V(k);
    end

    Z(~X) = {zeros(size(V{1}))};
    M = cell2mat(Z);
end