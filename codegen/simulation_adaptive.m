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

% Variables for the adaptive step method
sim_err_tolerance = 0.0010;
sim_err_threshold = 0.001;
sim_pow = 1/5;

% Bucher tableau
sim_a = [ 1/5    3/40   44/45   19372/6561    9017/3168      35/384
            0    9/40  -56/15  -25360/2187      -355/33           0
            0       0    32/9   64448/6561   46732/5247    500/1113
            0       0       0     -212/729       49/176     125/192
            0       0       0            0  -5103/18656  -2187/6784
            0       0       0            0            0       11/84
            0       0       0            0            0           0 ];

sim_b = [ 71/57600; 0; -71/16695; 71/1920; -17253/339200; 22/525; -1/40 ];

sim_c = [ 1/5, 3/10, 4/5, 8/9, 1, 1];

% Initial value vector
sim_y = [ Q.value ];

% Differential vector at the beginning
sim_dy = simulation_adaptive_ode(sim_time, sim_y);

% Initialize delta matrix
sim_k = zeros(length(sim_y), 7);
sim_k(:,1) = sim_dy;

% Initial-Schritt berechnen aus allen Anfangswerten
sim_hmax = 0.5;
sim_hfactor = 1.25;
sim_h = 1 / (norm(sim_dy ./ max(abs(sim_y), sim_err_threshold), inf) / (0.8 * sim_err_tolerance^sim_pow));
sim_finish = false;
while ~sim_finish

	% Kleinstmöglicher Schritt
	sim_hmin = 16*eps(sim_time);

	% Schritt zwischen sim_hmin und sim_hmax
	sim_h    = min(sim_hmax, max(sim_hmin, sim_h));

	% Shrink sim_h if it would overflow
	if (sim_time + sim_h) > sim_end
		sim_h = sim_end - sim_time;
		sim_finish = true;
	end;

	% Variable sim_time und sim_y werden nicht verändert
	% Nur sim_h kann erniedrigt werden
	sim_nofail = true;
	while true
		sim_ha = sim_h * sim_a;
		sim_hc = sim_h * sim_c;

		sim_k(:,2) = simulation_adaptive_ode(sim_time + sim_hc(1), sim_y + sim_k * sim_ha(:,1));
		sim_k(:,3) = simulation_adaptive_ode(sim_time + sim_hc(2), sim_y + sim_k * sim_ha(:,2));
		sim_k(:,4) = simulation_adaptive_ode(sim_time + sim_hc(3), sim_y + sim_k * sim_ha(:,3));
		sim_k(:,5) = simulation_adaptive_ode(sim_time + sim_hc(4), sim_y + sim_k * sim_ha(:,4));
		sim_k(:,6) = simulation_adaptive_ode(sim_time + sim_hc(5), sim_y + sim_k * sim_ha(:,5));

		sim_timenew = sim_time + sim_hc(6);

		% dy
		sim_dynew = sim_k * sim_ha(:,6);

		% y = y + dy
		sim_ynew = sim_y + sim_dynew;

		sim_k(:,7) = simulation_adaptive_ode(sim_timenew, sim_ynew);

		% Fehler zwischen 4. und 5. Ordnung ausrechnen
		sim_err = sim_h * norm((sim_k * sim_b) ./ max(max(abs(sim_y), abs(sim_ynew)), sim_err_threshold), inf);

		% Guter Schritt
		% falls minimale Schrittweite erreicht wurde
		% oder Fehler noch in der Toleranz liegen, brich ab
		if (sim_h <= sim_hmin || sim_err <= sim_err_tolerance)
			break;

		% Fehlerhafter Schritt
		% sim_h erniedrigen und die ganze Rechnung nochmals durchführen
		else
			sim_finish = false;
			if sim_nofail
				sim_nofail = false;
				sim_h = max(sim_hmin, sim_h * max(0.1, 0.8*(sim_err_tolerance/sim_err)^sim_pow));
			else
				sim_h = max(sim_hmin, 0.5 * sim_h);
			end;
		end;

	end;
	% If this step hasn't been downscaled, scale it up
	if sim_nofail
		sim_timeemp = sim_hfactor*(sim_err/sim_err_tolerance)^sim_pow;
		if sim_timeemp > 0.2
			sim_h = sim_h / sim_timeemp;
		else
			sim_h = 5.0*sim_h;
		end;
	end;

	% Die neuen Werte sim_timenew, sim_ynew und sim_k entgültig speichern
	sim_time = sim_timenew;
	sim_y = sim_ynew;
	sim_dy = sim_dynew;
	sim_k(:,1) = sim_k(:,7);

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
