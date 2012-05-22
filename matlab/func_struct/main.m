clear all;
close all;
clc;

model.x = 50;
model.y = 100;
model.z = 150;

result = func(model);

fprintf(1, '%d/%d/%d => %d\n', model.x, model.y, model.z, result);
