% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Everything global
global Q R UB C UC UR;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;
sim_dt = 0.1;

% Time variable
sim_time = sim_start;

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

sim_count = ceil(sim_end / sim_dt) - ceil(sim_start / sim_dt);

% Debug only!
x = zeros(1, sim_count);

sim_a = [ 0   0   0   0
          1/2 0   0   0
          0   1/2 0   0
          0   0   1   0 ];

sim_b = [ 1/6 1/3 1/3 1/6 ];

sim_c = [ 0 1/2 1/2 1 ];

y0 = [ Q.value ];

for i = 1 : sim_count + 1
    k = zeros(4,1);
    
	% Flow calculations
	I.value = UR.value/R.value;

	% Container calculations
	simulation_dy(

	% Parameter calculations
	UC.value = Q.value/C.value;
	UR.value = UB.value-UC.value;

	% Save calculations
	fprintf(Q.fp, '%f\t%e\n', sim_time, Q.value);
	fprintf(R.fp, '%f\t%e\n', sim_time, R.value);
	fprintf(UR.fp, '%f\t%e\n', sim_time, UR.value);
	fprintf(UB.fp, '%f\t%e\n', sim_time, UB.value);
	fprintf(UC.fp, '%f\t%e\n', sim_time, UC.value);
	fprintf(C.fp, '%f\t%e\n', sim_time, C.value);

	% Debug only!
	x(i)=UC.value;

    % t0 = t0 + h
	sim_time = sim_time + sim_dt;
end;

% Close output files
fclose(Q.fp);
fclose(R.fp);
fclose(UR.fp);
fclose(UB.fp);
fclose(UC.fp);
fclose(C.fp);

% Debug only!
t = sim_start:sim_dt:sim_end;
plot(t,x,'r','LineWidth',2);
legend('dt=0.1',2);
title('Euler');

