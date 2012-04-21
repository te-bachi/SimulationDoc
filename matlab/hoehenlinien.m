clear all;
close all;
clc;

x = -5:0.1:5;
y = -5:0.1:5;

xlen = length(x);
ylen = length(y);
for i = 1:xlen
    for j = 1:ylen
        f(i,j) = cos(x(i)) + sin(y(j));
    end;
end;

% contour(f);
% contourf(f);
surfc(x,y,f);

