clc
clear
close all

m=125;
nb=10;
grid=5;

[g,G,Q,acc]=solve_problems(m,nb,grid);

save("results.mat");