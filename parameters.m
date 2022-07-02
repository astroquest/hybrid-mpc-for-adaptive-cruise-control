%% vehicle

m = 800;
c = 0.4;
b = 3700;
gamma = 0.87;


%% input

u_max = 1.3;
u_min = -1.3;
a_comf_max = 2.5;


%% velocity

v_12 = 15;
v_23 = 30;
v_max = sqrt(1/c * b/(1+gamma*3)*u_max);


%% pwa

alpha = 28.8575;
beta = 249.8266;

a_1 = beta/alpha;
b_2 = ( beta/alpha*v_max - c*v_max^2 ) / ( v_max/alpha - 1 );
a_2 = 1/alpha*(beta - b_2);


%% mld max/min

M_1 = v_12;
m_1 = v_12 - v_max;
M_2 = alpha;
m_2 = alpha - v_max;
M_3 = v_23;
m_3 = v_23 - v_max;

M_v = v_max;
m_v = 0;

M_u = u_max;
m_u = u_min;


%% misc

eps = 0; %2^(-20);  % machine precision  (works fine if equal to zero)

lambda = 0.1;  % scalar weight for input in cost function

