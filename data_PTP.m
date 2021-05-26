clc
clear
close all

m=20;
nb=10;
grid=20;

[g,G,Q,X,D,acc]=solve_problems(m,nb,grid);

save("results.mat");