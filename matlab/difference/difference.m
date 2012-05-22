
clear all;
close all;
clc;

m = [ 1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1 ];


m(3,3) = 6;

[ m_dx m_dy ] = gradient(m);