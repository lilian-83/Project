clc
clear
close all

m=150;
nb=20;
grid=500;

[g,G,Q,acc]=solve_problems(m,nb,grid);

save("results.mat");
