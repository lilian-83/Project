clc
clear
close all

m=500;
nb=10;
grid=200;

[g,G,Q,X,D,acc]=solve_problems(m,nb,grid);

save("results.mat");
