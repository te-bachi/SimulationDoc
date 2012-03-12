a=0; b=2;
n=9;
t0=0; y0=1;
syms t;
y(1)=0*t+1;
disp('Folgenglieder der Iteration:');
disp(' ');
disp(y(1));
 ezplot(y(1),[a b]);
%j=a:0.001:b; plot(j,subs(y(1),j),'Color',[n/(n-1) 0 0],'LineWidth',2);
hold on;
for i=2:n
    y(i)=y0+int(picard_f(t,y(i-1)))-int(picard_f(t,y(i-1)),0,t0);
%    plot(j,subs(y(i),j),'Color',[(n-i)/(n-1) 0 0],'LineWidth',2);
    ezplot(y(i),[a b]);
    disp(y(i));
    hold on;
end
hold off;
title('Picard-Iteration');