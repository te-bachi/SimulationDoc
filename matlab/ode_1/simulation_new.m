% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Everything global
global Q R UB C UC UR;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;

% Init container values
Q.value = 0.0; % constant

% Init parameter and flow values
R.value = 1250.0; % constant
UB.value = 9.0; % constant
C.value = 5.2E-4; % constant
UC.value = Q.value/C.value;
UR.value = UB.value-UC.value;

% Open output files
Q.fp = fopen('Q_data.txt', 'w');
R.fp = fopen('R_data.txt', 'w');
UR.fp = fopen('UR_data.txt', 'w');
UB.fp = fopen('UB_data.txt', 'w');
UC.fp = fopen('UC_data.txt', 'w');
C.fp = fopen('C_data.txt', 'w');

%% 
x0 = [ sim_start sim_end ];
y0 = [ Q.value ];
options = odeset('NonNegative', 1);
[x, y] = ode45('simulation_dy', x0, y0, options);
%%

% Close output files
fclose(Q.fp);
fclose(R.fp);
fclose(UR.fp);
fclose(UB.fp);
fclose(UC.fp);
fclose(C.fp);
