clc;
clear all;
close all;

% a = dv = d2s
% v = ds
% s

%% Zeit (2D-Vektor "von" "bis")
x0 = [0 5];

%% Container (Initialwert)
% y0(1) = s0 = 0 m
% y0(2) = v0 = 15 m/s
y0 = [15 0];

%% Ordinary Differential Equation
% options = odeset('NonNegative', 1, 'MaxStep', 0.01, 'InitialStep', 0.1);
options = odeset('NonNegative', 1);

% x = Zeit
% y(1) = s
% y(2) = v
[x, y] = ode45('dy_f', x0, y0, options);

% Zeige nur y(1) an
plot(x, y(:, 1), 'r', 'LineWidth', 2);

title('ode45');

