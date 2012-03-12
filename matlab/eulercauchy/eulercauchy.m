clc;
clear all;
close all;

a=0; b=50;
lambda0=5;
x0=0; x1=5;
eps=0.0001;
x=[x0; x1];
for i=1:ceil(b/eps)
    x(1:2,i+1)=x(1:2,i)+eps*eulercauchy_f(x(1:2,i),lambda0);
end

t=0:eps:b;
plot(t,x(2,:),'r','LineWidth',2);
legend('eps=0.01',2);
title('Euler-Cauchy-Verfahren');