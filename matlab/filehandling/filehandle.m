
clear all;
close all;
clc;

% Predefined constants
sim_start = 0.0;
sim_end = 50.0;
sim_time = 0.0;
sim_dt = 0.1;

xymodel.width = 800;
xymodel.height = 600;

for x = 1:xymodel.width
	for y = 1:xymodel.height
		density.d1.matrix(y, x) = 10*sin(x/2)+10*cos(y/2);
	end;
end;

sim_count = ceil(sim_end / sim_dt);

progressOld = 0;
progressNew = 0;
c1 = clock;

for i = 1:sim_count
    progressNew = uint8(100*sim_time/sim_count);
    if progressNew > progressOld
        c2 = clock;
        fprintf(1, 'progress %d (%2.2fs)\n', progressNew, etime(c2, c1));
        fclose(fopen(strcat('progress_', int2str(progressNew)), 'w'));
        progressOld = progressNew;
    end;
    [dx dy] = gradient(density.d1.matrix);
    sim_time = sim_time + sim_dt;
end;

    
