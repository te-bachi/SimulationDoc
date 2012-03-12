% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Everything global
global Q R UB C UC UR i dt;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;
i = 2;
dt = 0;

% Init container values
Q.value(1) = 0.0; % constant

% Init parameter and flow values
R.value(1) = 1250.0; % constant
UB.value(1) = 9.0; % constant
C.value(1) = 5.2E-4; % constant
UC.value(1) = Q.value/C.value;
UR.value(1) = UB.value-UC.value;

R.time(1) = 0.0;
UB.time(1) = 0.0;
C.time(1) = 0.0;
UC.time(1) = 0.0;
UR.time(1) = 0.0;

%% 
x0 = [ sim_start sim_end ];
y0 = [ Q.value ];
options = odeset('NonNegative', 1);
[x, y] = ode45('simulation_dy', x0, y0, options);
%%

