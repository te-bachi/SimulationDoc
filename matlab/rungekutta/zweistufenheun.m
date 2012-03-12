
a=0; b=10;
x0=0; x1=5;
eps=0.01;
x=[x0; x1];
for i=1:ceil(b/eps)
    k(1:2,1)=rungekutta_f(x(1:2,i));
    k(1:2,2)=rungekutta_f(x(1:2,i)+eps*k(1:2,1));
    x(1:2,i+1)=x(1:2,i)+0.5*eps*(k(1:2,1)+k(1:2,2));
end
t=0:eps:b;
plot(t,x(2,:),'r','LineWidth',2);
legend('eps=0.01',2);
title('Zweistufiges Heun-Verfahren');