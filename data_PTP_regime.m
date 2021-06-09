clc
clear
close all

tic

m=150;
nb=20;
grids=100;

[g1,G1,Q1,acc1]=solve_problems_regime_par(m,nb,grids);

save("results_regime.mat");

toc
