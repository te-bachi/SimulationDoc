
clear all;
close all;
clc;

m = [ 1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1 ];

[ m_dx m_dy ] = gradient(m);

m(2,2) = 6;
m(4,4) = 6;

[ m_dx(1:3,1:3) m_dy(1:3,1:3) ] = gradient(m(1:3,1:3));
[ m_dx(3:5,3:5) m_dy(3:5,3:5) ] = gradient(m(3:5,3:5));
