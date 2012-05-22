

clear all;
close all;
clc;

m = [ 1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 6 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1
      1 1 1 1 1 1 ];

[ m_dx m_dy ] = sim_gradient(m);


e = [ 1 2 3 4 5 6
      1 2 3 4 5 6
      1 2 3 4 5 6
      1 2 3 4 5 6
      1 2 3 4 5 6
      1 2 3 4 5 6 ];
  
[ e_dx e_dy ] = sim_gradient(e);
