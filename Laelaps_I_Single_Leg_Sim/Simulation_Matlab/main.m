% Simulation and animation of a 2 segment springy leg with fixed base
% Dynamics derived with Mathematica 
% Mathematica file:"two_segment_springy_leg_fixed_base"

%-------------------------------------------------------------------------%
% Enable/ Disable EOM solving, amimation
%-------------------------------------------------------------------------%
clear global; clear all; clc;
global m1 m2 m3 I1 I2 I3 d1 d2 d3 g Lspring kspring bspring
global xoutE toutE tau1E tau2E FyE FxE


%-------------------------------------------------------------------------%
% Simulation duration
%-------------------------------------------------------------------------%
tstart = 0;
tfinal = 3;


%-------------------------------------------------------------------------%
% System parameters (for the hind leg of Laelaps I)
%-------------------------------------------------------------------------%
% Link 1
m1 = 0.6; % link 1 mass
d1 = 0.125; % distance from link's COM to link's joint
Ilink1 = m1*(2*d1)^2/3; % link 1 moment of inertia
Irotor1 = 0.0000542; % rotor's MoI
ngear1 = 53 * (48/26); % gear ratio (97.8462)
I1 = Ilink1 + Irotor1 * ngear1 ^ 2; % total MoI that motor 1 has to drive
% Link 2
m2 = 0.5; % link 2 mass
d2 = 0.07; %0.075; % distance from link's COM to link's joint
Ilink2 = m2*(2*d2)^2/3; % link 2 moment of inertia
Irotor2 = 0.0000209; % rotor's MoI
ngear2 = 43 * (48/26); % gear ratio (79.3846)
I2 = Ilink2 + Irotor2 * ngear2 ^ 2; % total MoI that motor 2 has to drive
% Link 3
m3 = 0.23; % link 3 mass
d3 = 0.205; %0.075; % distance from link's COM to link's joint
I3 = m3*(2*d3)^2/3; % link 3 moment of inertia


%-------------------------------------------------------------------------%
% Compliance between the 2nd and the 3rd segment
%-------------------------------------------------------------------------%
kspring = 12250; % Stiffness
bspring = 1; % Energy losses at springts
Lspring = 0.04; % Free length

% Gravity
g = 9.81;


%-------------------------------------------------------------------------%
% Initializing the EXTENDED output VECTORS 
% (these vectors include the whole history of data including the backs and 
% forths of the solvers in order to satisfy the desired accuracy
% i.e. these vectors are expected to have far more elements than output
% vectors and can be used for checking)
%-------------------------------------------------------------------------%
xoutE = []; % Coords and Velocities  - E stands for EXTENDED
toutE = []; % Time vector
tau1E = []; % Hip torque
tau2E = []; % Knee vector
FyE = []; % x Force at the foot
FxE = []; % y Force at the foot


%-------------------------------------------------------------------------%
% Solve the Equations of Motion  
% Matrix form: M(x,x') * x' = F(x,x')
%-------------------------------------------------------------------------%
% x(1) = th1 
% x(2) = th1dot 
% x(3) = th2
% x(4) = th2dot
% x(5) = l
% x(6) = ldot
%-------------------------------------------------------------------------%

% Set initial conditions
th1_0 = deg2rad(-50);
th1dot_0 = 0;
th2_0 = deg2rad(-50);
th2dot_0 = 0;
l_0 = Lspring;
ldot_0 = 0;

% Vector of initial conditions.
x0 = [th1_0, th1dot_0, th2_0, th2dot_0, l_0, ldot_0];

% Options for ODE
options = odeset('MaxStep',1e-3,'AbsTol',1e-9,'RelTol',1e-9,'Mass',@mass);

% Set the time interval
tspan = [tstart tfinal];

% Solve ODE
[t,x] = ode15s(@dynamics,tspan,x0,options);

% Save the results
xout = x; 
tout = t;


%-------------------------------------------------------------------------%
% Animation
%-------------------------------------------------------------------------%
animation
