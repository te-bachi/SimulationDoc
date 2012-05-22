clear all;
close all;
clc;

fp = fopen('C:\Users\bachi\matlab_lock.txt', 'w');
if fp == -1
    fprintf(1, 'can''t open\n');
    return;
end;
fprintf(1, 'open!\n');
fclose(fp);
