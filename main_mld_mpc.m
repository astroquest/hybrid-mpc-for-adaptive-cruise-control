close all
clear all
%% parameters
% Load all given parameters

parameters


%% simulation settings
% Set horizon, time, and optimization settings

Np = 5;             % prediction horizon
Nc = 4;             % control horizon

% Propagate the system with the approximated MLD model (1) 
%   or the actual continuous-time plant (2)
propagate = 2;

sim_time = 25;      % simulation time in seconds
T = .125;           % sample time in seconds

options = optimoptions("intlinprog", "Display", "none");


%% matrices
% Computes matrices that are constant throughout the optimization process.

matrices


%% preallocation
% Preallocation to improve execution speed.

N = sim_time/T;     % discrete steps
    
% Initialization is done with -1's for debugging purposes.

v           = -ones(N+1,1);
u           = -ones(N,1);
delta       = -ones(N,3);
z           = -ones(N,3);

v_ref       = -ones(N, 1);
V_ref       = -ones(Np,1);

x           = -ones(N,1);
a           = -ones(N,1);
Du          = -ones(N,1);

optim_time  = -ones(N,1);
cost        = -ones(N,1);


%% initial conditions
% Starting velocity, position, and acceleration.

v(1) = 0.9*alpha;
x(1) = 0;
a(1) = 0;


%% indices
% Predetermines which indices of the optimization variable vector theta
%   correspond to the values for u, delta, and z (first Np correspond to
%   velocity values).

index_u = Np+1;
index_delta = 2*Np+1:2*Np+3;
index_z = 5*Np+1:5*Np+3;

intcon = index_delta;  % set which optim. variables are integers


%% main loop
% Optimization and system propagation is executed in this block.

objective_function  % load coefficient matrix of the objective function

for k=1:N
    tic;

    reference_vector  % compute reference supervector for chosen prediction horizon

    constraint_vectors  % compute beta, beta_eq vectors, which depend on current velocity and reference

    optimization  % perform milp optimization and output vector theta containing the computed optimized input

    u(k)        = theta( index_u );

    if propagate == 1
        v(k+1)      = theta( 1 );
        delta(k,:)  = theta( index_delta );
        z(k,:)      = theta( index_z );
        a(k)        = ( v(k+1) - v(k) )/T;
    elseif propagate == 2
        ct_dynamics;  % computed input is used to propagate the continuous-time vehicle dynamics
        v(k+1) = v(k) + a(k)*T;
    end

    optim_time(k) = toc;
    cost(k) = fval;
end


%% additional information
% Compute position, throttle change, and performance from found values.

for j=1:N-1
    x(j+1)  = x(j) + v(j)*T;
    Du(j+1) = u(j+1) - u(j);
end

diff = sum(abs(v(1:end-1) - v_ref));  % compute performance metric to compare controller quality for different horizon settings


%% plots

plots  % make plots of all the necessary values

