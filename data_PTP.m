clc
clear
close all

tic

m=150;
nb=10;
grid=5;

[g,G,Q,acc]=solve_problems(m,nb,grid);

save("results.mat");

toc
