
clear all;
close all;
clc;

ax = 3;
ay = 3;
bx = 4;
by = 3;

m = [ 1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1 ];

[ m_dx m_dy ] = gradient(m);

m(ay,ax) = 6;
m(by,bx) = 6;

[ m_dx(ay-1:ay+1,ax-1:ax+1) m_dy(ay-1:ay+1,ax-1:ax+1) ] = gradient(m(ay-1:ay+1,ax-1:ax+1));
[ m_dx(by-1:by+1,bx-1:bx+1) m_dy(by-1:by+1,bx-1:bx+1) ] = gradient(m(by-1:by+1,bx-1:bx+1));

