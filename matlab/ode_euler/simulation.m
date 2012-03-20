% Generated file by Simulation

% Cleanup

clc; clear all; close all;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;
sim_dt = 0.01;

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

for i = 1 : sim_count + 1
	sim_time = sim_time + sim_dt;

	% Flow calculations
	I.value=UR.value/R.value;

	% Container calculations
	Q.value = Q.value + I.value * sim_dt;

	% Parameter calculations
	UC.value=Q.value/C.value;
	UR.value=UB.value-UC.value;

	% Save calculations
	x(i)=Q.value;
	fprintf(Q.fp, '%e\n', Q.value);
	fprintf(R.fp, '%e\n', R.value);
	fprintf(UR.fp, '%e\n', UR.value);
	fprintf(UB.fp, '%e\n', UB.value);
	fprintf(UC.fp, '%e\n', UC.value);
	fprintf(C.fp, '%e\n', C.value);
end
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
legend('dt=0.01',2);
title('Euler');
