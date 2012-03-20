
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

sim_a = [ 0   0   0   0
          1/2 0   0   0
          0   1/2 0   0
          0   0   1   0 ]';

sim_b = [ 1/6 1/3 1/3 1/6 ]';

sim_c = [ 0 1/2 1/2 1 ];

for i=1:ceil(b/eps)
    k = zeros(2, 4);
    k(:,1)=rungekutta_f(x(:,i)+eps*k*sim_a(:,1)); 
    k(:,2)=rungekutta_f(x(:,i)+eps*k*sim_a(:,2));
    k(:,3)=rungekutta_f(x(:,i)+eps*k*sim_a(:,3));
    k(:,4)=rungekutta_f(x(:,i)+eps*k*sim_a(:,4));
    
    % s = s + dx * dt
    % v = v + (dv - ds) * dt
    m = k*sim_b;
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
