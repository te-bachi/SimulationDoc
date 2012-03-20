% Generated file by Simulation

% Cleanup
clc; clear all; close all;

% Predefined constants
sim_start = 0.0;
sim_end = 3.0;
sim_dt = 0.01;

% Time variable
sim_time = sim_start;

% Init container values
v.value = 15.0;
s.value = 0.0;

% Init parameter values

% Open output files
v.fp = fopen('v_data.txt', 'w');
s.fp = fopen('s_data.txt', 'w');

sim_count = ceil(sim_end / sim_dt) - ceil(sim_start / sim_dt);

% Debug only!
x = zeros(2, sim_count);

for i = 1 : sim_count + 1
	% Flow calculations
    dv.value = -9.81;
	ds.value = v.value;

	% Container calculations
	v.value = v.value + (-ds.value+dv.value) * sim_dt;
	s.value = s.value + ds.value * sim_dt;
    
    %if (v.value < 0)
    %    v.value = 0;
    %end;
    
    if (s.value < 0)
        s.value = 0;
    end;

	% Parameter calculations

	% Save calculations
	fprintf(v.fp, '%f\t%e\n', sim_time, v.value);
	fprintf(s.fp, '%f\t%e\n', sim_time, s.value);

	% Debug only!
	x(1,i)=s.value;
	x(2,i)=v.value;

	sim_time = sim_time + sim_dt;

end

% Close output files
fclose(v.fp);
fclose(s.fp);

% Debug only!
t = sim_start:sim_dt:sim_end;

figure(1);
plot(t,x(1,:),'r','LineWidth',2);
legend('dt=0.1',2);
title('Euler');

figure(2);
plot(t,x(2,:),'r','LineWidth',2);
legend('dt=0.1',2);
title('Euler');

