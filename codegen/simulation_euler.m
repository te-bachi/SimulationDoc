% Generated file by Simulation

% Cleanup
clc; clear all; close all;

% DEBUG
tmp_idx = 1;
tmp_y = zeros(8,1000);

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

sim_count = ceil(sim_end / sim_dt) - ceil(sim_start / sim_dt);

for i = 1 : sim_count + 1
	% Flow calculations
	I.value = UR.value/R.value;

	% Container calculations
	Q.value = Q.value + I.value * sim_dt;

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
	fprintf(I.fp, '%f\t%e\n', sim_time, I.value);

	% DEBUG
	tmp_y(1, tmp_idx) = sim_time;
	tmp_y(2, tmp_idx) = Q.value;
	tmp_y(3, tmp_idx) = R.value;
	tmp_y(4, tmp_idx) = UR.value;
	tmp_y(5, tmp_idx) = UB.value;
	tmp_y(6, tmp_idx) = UC.value;
	tmp_y(7, tmp_idx) = C.value;
	tmp_y(8, tmp_idx) = I.value;
	tmp_idx = tmp_idx + 1;

	sim_time = sim_time + sim_dt;

end

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
