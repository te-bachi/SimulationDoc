% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Everything global
global R UB C;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;
sim_count = 0;

% Init container values
Q.value = 0.0; % constant

% Init parameter and flow values
R.value = 1250.0; % constant
UB.value = 9.0; % constant
C.value = 5.2E-4; % constant
UC.value = Q.value/C.value;
UR.value = UB.value-UC.value;

%% 
x0 = [ sim_start sim_end ];
y0 = [ Q.value ];
%options = odeset('NonNegative', 1);
%options = odeset('Refine', 1);
options = odeset('InitialStep', 0.01, 'MaxStep', 0.5, 'Refine', 1);
[x, y] = ode45('matlab_dy', x0, y0, options);
%%

stem(x, y(:,1));
