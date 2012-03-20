clc;
clear all;
close all;

% a = dv = d2s
% v = ds
% s

%% Zeit (2D-Vektor "von" "bis")
x0 = [0 10];

%% Container (Initialwert)
% y0(1) = s0 = 0 m
% y0(2) = v0 = 15 m/s
y0 = [0 5];

%% Ordinary Differential Equation
% options = odeset('NonNegative', 1, 'MaxStep', 0.01, 'InitialStep', 0.1);
options = odeset('Refine', 4);
%options = odeset('NonNegative', 1);

% x = Zeit
% y(1) = s
% y(2) = v
[x, y] = ode45('matlab_sim_dy', x0, y0, options);

%% DEBUG
figure(1);
stem(x, y(:,2));
figure(2);
plot(x, y(:,2));
