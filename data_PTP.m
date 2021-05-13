clc
clear
close all

m=500;
nb=10;
grid=100;

[g,G,Q,X,D,acc1]=solve_problems(m,nb,grid);

save("results.mat");