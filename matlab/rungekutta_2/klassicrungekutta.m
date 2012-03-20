
clc;
clear all;
close all;

% Zeit von 0 bis 3
a=0; b=3;

% Anfangswerte
% s = 0
% v = 15
x0=0; x1=15;
x=[x0; x1];

% DT
eps=0.1;

for i=1:ceil(b/eps)
    k(1:2,1)=rungekutta_f(x(1:2,i)); 
    k(1:2,2)=rungekutta_f(x(1:2,i)+eps*0.5*k(1:2,1));
    k(1:2,3)=rungekutta_f(x(1:2,i)+eps*0.5*k(1:2,2));
    k(1:2,4)=rungekutta_f(x(1:2,i)+eps*k(1:2,3));
    
    % s = s + dx * dt
    % v = v + (dv - ds) * dt
    m = ((1/6)*k(1:2,1)+(1/3)*k(1:2,2)+(1/3)*k(1:2,3)+(1/6)*k(1:2,4));
    x(1,i+1)=x(1,i)+eps*m(1,1);
    x(2,i+1)=x(2,i)+eps*(m(2,1)-m(1,1));
end
t=0:eps:b;
plot(t,x(1,:),'r','LineWidth',2);
legend('eps=0.1',2);
title('s');

figure(2)
plot(t,x(2,:),'r','LineWidth',2);
legend('eps=0.1',2);
title('v');
