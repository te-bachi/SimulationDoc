

clear all;
close all;
clc;

m = [  0  0  0  0  0  0  0
       0  0  0  0  0  0  0
       0  0  0  0  0  0  0
       0  0  0 255 0  0  0
       0  0  0  0  0  0  0
       0  0  0  0  0  0  0
       0  0  0  0  0  0  0 ];

dt = 1;

for t = 1:20
    % hold on;
    image(m);
    pause(1);
    m = sim_diffusion(m, dt, 0.1);
end;
