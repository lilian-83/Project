clc
clear
close all

tic

m=150;
nb=20;
grid=10;

[g,G,Q,acc]=solve_problems(m,nb,grid);

save("results.mat");

toc
