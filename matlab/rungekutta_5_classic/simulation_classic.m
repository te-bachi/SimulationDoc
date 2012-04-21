% Generated file by Simulation

% Cleanup
clc; clear all; close all;

% Global constant parameters
global D

% DEBUG
tmp_idx = 1;
tmp_y = zeros(3,1000);

% Predefined constants
sim_start = 0.0;
sim_end = 10.0;

% Time variable
sim_time = sim_start;
sim_h = 0.02;

% Init container values
v.value = 0.0;
s.value = 10.0;

% Init parameter values
D.value = 50.0; % constant

% Flow calculations
dv.value = -D.value*s.value;
ds.value = v.value;

% Bucher tableau

sim_a = [ 0   1/2     0   0
          0     0   1/2   0
          0     0     0   1
          0     0     0   0 ];

sim_b = [ 1/6; 1/3; 1/3; 1/6 ];

sim_c = [ 0 1/2 1/2 1 ];

% Initial value vector
sim_y = [ v.value; s.value ];

% Differential vector at the beginning
sim_dy = simulation_dy(sim_time, sim_y);

% Initialize delta matrix
sim_k = zeros(length(sim_y), 4);

for i = 1:ceil(sim_end / sim_h)
    sim_k(:,1)=simulation_dy(sim_time + sim_c(1), sim_y + sim_h * sim_k * sim_a(:,1));
    sim_k(:,2)=simulation_dy(sim_time + sim_c(2), sim_y + sim_h * sim_k * sim_a(:,2));
    sim_k(:,3)=simulation_dy(sim_time + sim_c(3), sim_y + sim_h * sim_k * sim_a(:,3));
    sim_k(:,4)=simulation_dy(sim_time + sim_c(4), sim_y + sim_h * sim_k * sim_a(:,4));
    
    % t = t + h
    sim_time = sim_time + sim_h;
    
    % y = y + t * dy
    sim_y(1,1) = sim_y(1,1) + sim_h * sim_k(1,:) * sim_b;
    sim_y(2,1) = sim_y(2,1) + sim_h * sim_k(2,:) * sim_b;
    
	% DEBUG
	tmp_y(1, tmp_idx) = sim_time;
	tmp_y(2, tmp_idx) = sim_y(1,1);
	tmp_y(3, tmp_idx) = sim_y(2,1);
	tmp_idx = tmp_idx + 1;
end

% DEBUG
tmp_res = tmp_y(:, 1:tmp_idx-1);
figure(1);
stem(tmp_res(1,:), tmp_res(2,:));
figure(2);
stem(tmp_res(1,:), tmp_res(3,:));

