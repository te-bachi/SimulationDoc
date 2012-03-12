clc;
clear all;
close all;

a=0;
b=10;
step=0.1;
x0 = 0;
y0 = 0;

y = rk4('quad', x0, y0, b, step);

x=a:step:b;
plot(x, y, 'r', 'LineWidth', 2);

title('Klassisches Runge-Kutta-Verfahren');
