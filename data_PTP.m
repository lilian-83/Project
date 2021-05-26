clc
clear
close all

m=125;
nb=20;
grid=200;

[g,G,Q,acc]=solve_problems(m,nb,grid);

save("results.mat");