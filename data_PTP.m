%Use the function solve_problems (parallelized version or not, you can
%change in the code) to obtain data for different realisations of the
%binary SBM (using the function bin_SBM) and store data in the file
%"results.mat"

clc
clear
close all

tic

m=150;
nb=20;
grid=20;

[g,G,Q,acc]=solve_problems_par(m,nb,grid);

save("results.mat");

toc
