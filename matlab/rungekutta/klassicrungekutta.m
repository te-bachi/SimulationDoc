
clc;
clear all;
close all;

a=0; b=10;
x0=0; x1=5;
eps=0.01;
x=[x0; x1];
for i=1:ceil(b/eps)
    % x = unabhängig
    % y = abhängig
    % y0'=f(x,y)
    k(1:2,1)=rungekutta_f(x(1:2,i));
    
    % eps = h
    % yA = y0 + h/2 
    k(1:2,2)=rungekutta_f(x(1:2,i)+eps*0.5*k(1:2,1));
    k(1:2,3)=rungekutta_f(x(1:2,i)+eps*0.5*k(1:2,2));
    k(1:2,4)=rungekutta_f(x(1:2,i)+eps*k(1:2,3));
    x(1:2,i+1)=x(1:2,i)+eps*((1/6)*k(1:2,1)+(1/3)*k(1:2,2)+(1/3)*k(1:2,3)+(1/6)*k(1:2,4));
end
t=0:eps:b;
plot(t,x(2,:),'r','LineWidth',2);
legend('eps=0.01',2);
title('Klassisches Runge-Kutta-Verfahren');

