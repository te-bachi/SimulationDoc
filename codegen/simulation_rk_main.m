% Generated file by Simulation

% Cleanup
clc; clear all; close all;

% Global constant parameters
global Q R UR UB UC C I;

% Predefined constants
sim_start = 0.0;
sim_end = 5.0;

% Time variable
sim_time = sim_start;
sim_dt = 0.1;

% Init container values
Q.value = 0.0;

% Init parameter values
R.value = 1250.0; % constant
UB.value = 9.0; % constant
C.value = 5.2E-4; % constant
UC.value = Q.value/C.value;
UR.value = UB.value-UC.value;

% Flow calculations
I.value = UR.value/R.value;

% Open output files
Q.fp = fopen('Q_data.txt', 'w');
R.fp = fopen('R_data.txt', 'w');
UR.fp = fopen('UR_data.txt', 'w');
UB.fp = fopen('UB_data.txt', 'w');
UC.fp = fopen('UC_data.txt', 'w');
C.fp = fopen('C_data.txt', 'w');
I.fp = fopen('I_data.txt', 'w');

% Save calculations
fprintf(Q.fp, '%f\t%e\n', sim_time, Q.value);
fprintf(R.fp, '%f\t%e\n', sim_time, R.value);
fprintf(UR.fp, '%f\t%e\n', sim_time, UR.value);
fprintf(UB.fp, '%f\t%e\n', sim_time, UB.value);
fprintf(UC.fp, '%f\t%e\n', sim_time, UC.value);
fprintf(C.fp, '%f\t%e\n', sim_time, C.value);
fprintf(I.fp, '%f\t%e\n', sim_time, I.value);

% Bucher tableau
sim_a = [ 0   1/2     0   0
          0     0   1/2   0
          0     0     0   1
          0     0     0   0 ];

sim_b = [ 1/6; 1/3; 1/3; 1/6 ];

sim_c = [ 0 1/2 1/2 1 ];

% Initial value vector
sim_y = [ Q.value ];

% Initialize delta matrix
sim_k = zeros(length(sim_y), 4);

sim_count = ceil(sim_end / sim_dt);

for i = 1:sim_count
	sim_k(:,1) = simulation_rk_ode(sim_time + sim_c(1), sim_y + sim_dt * sim_k * sim_a(:,1));
	sim_k(:,2) = simulation_rk_ode(sim_time + sim_c(2), sim_y + sim_dt * sim_k * sim_a(:,2));
	sim_k(:,3) = simulation_rk_ode(sim_time + sim_c(3), sim_y + sim_dt * sim_k * sim_a(:,3));
	sim_k(:,4) = simulation_rk_ode(sim_time + sim_c(4), sim_y + sim_dt * sim_k * sim_a(:,4));

	% t = t + dt
	sim_time = sim_time + sim_dt;

	% dy
	sim_dy = sim_k * sim_b;

	% y = y + dt * dy
	sim_y = sim_y + sim_dt * sim_dy;

	% Convert vector to container/flow
	Q.value = sim_y(1);
	I.value = sim_dy(1);

	% Save calculations
	fprintf(Q.fp, '%f\t%e\n', sim_time, Q.value);
	fprintf(R.fp, '%f\t%e\n', sim_time, R.value);
	fprintf(UR.fp, '%f\t%e\n', sim_time, UR.value);
	fprintf(UB.fp, '%f\t%e\n', sim_time, UB.value);
	fprintf(UC.fp, '%f\t%e\n', sim_time, UC.value);
	fprintf(C.fp, '%f\t%e\n', sim_time, C.value);
	fprintf(I.fp, '%f\t%e\n', sim_time, I.value);

end;
% Close output files
fclose(Q.fp);
fclose(R.fp);
fclose(UR.fp);
fclose(UB.fp);
fclose(UC.fp);
fclose(C.fp);
fclose(I.fp);
fclose(fopen('matlab_finish.txt', 'w'));

exit
