clear all;
close all;
clc;

A = [  0  0  0  0  0  0
       0  0  0  0  0  0
       0  1  4  8  4  0
       0  2  8 16  2  0
       0  1  4  8  4  0
       0  0  0  0  0  0 ];
   
[ylen xlen] = size(A);

B = cat(2, A, A(:,xlen));
B = cat(1, B, B(ylen,:));

C = cat(2, B(:,1), B);
C = cat(1, C(1,:), C);

grad_diff = diff(B);
lap_diff = diff(diff(C));

grad_grad = gradient(B);
lap_del2 = del2(C);
