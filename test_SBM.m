% Solves the Binary Stochastic Block Model for a random graph generated as
% in the paper of N.Boumal with probabilities p and q.
%
% - m represents the number of nodes in one class, ie the total number of nodes
%   of the graph is 2*m
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge

clc;
clear;
close all;

%Define the total number of nodes n
m=50; %number of nodes in one cluster
n=2*m; %total number of nodes

%Define p and q
p=0.6;
q=0.3;

%Create graph (first m nodes=1, last m nodes=-1) by creating adjacency
%matrix using that it is symmetric

A1=binornd(1,p,m,m); %edges between +1 nodes
A3=binornd(1,p,m,m); %edges between -1 nodes

A1=triu(A1);
A3=triu(A3);

A1=A1+A1'-diag(diag(A1));
A3=A3+A3'-diag(diag(A3));

A2=binornd(1,q,m,m); %edges between +1/-1 nodes

A=[A1 A2; A2' A3];

G=graph(A);
%plot(G);

%Define A#
B=A-(p+q)/2*ones(n,n);

%Solve the problem
 
% Create the problem structure.
manifold = obliquefactory(2, n, true);
problem.M = manifold;
 
% Define the problem cost function and its derivatives.
problem.cost = @(X) -trace(X'*B*X);
egrad = @(X) -2*B*X;
ehess = @(X, U) -2*B*U;
problem.grad = @(X) manifold.egrad2rgrad(X, egrad(X));
problem.hess = @(X, U) manifold.ehess2rhess(X, egrad(X), ehess(X, U), U);
 
% Numerically check the differentials.
% checkgradient(problem); pause;
% checkhessian(problem); pause;

%Solve
Q = trustregions(problem);

%Find the truth vector
X=Q*Q';
[V,D]=eig(X);
g=sqrt(n)*V(:,n);
% disp(V);
% disp(diag(D));
% disp(g);