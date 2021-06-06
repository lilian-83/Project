function [g,A,Q,X,D]=bin_SBM(m,p,q)
% function [g,G,Q,D]=bin_SBM(m,p,q)
%
% Solves the Binary Stochastic Block Model with the Bureir-Monteiro approach
% (optimization on a product of circles) for a random graph generated as
% in the paper of N.Boumal with probabilities p and q.
%
% Inputs :
% - m represents the number of nodes in one class, ie the total number of nodes
%   of the graph is 2*m
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge
%
% Outputs :
% - g is the vector of labels that the algorithm finds
% - A is the adjacency matrix of the random graph generated
% - Q is the solution of the SDP written with the Bureir Monteiro approach
%   (rank 2 constraint), X=Q*Q'
% - X is the solution of the SDP relaxation of the MLE
% - D is the vector of eingenvalues of the matrix X

%Define the total number of nodes n
n=2*m; %total number of nodes

%Create graph (first m nodes=1, last m nodes=-1) by creating adjacency A
%matrix using that it is symmetric

A1=binornd(1,p,m,m); %edges between +1 nodes
A3=binornd(1,p,m,m); %edges between -1 nodes

A1=triu(A1);
A3=triu(A3);

A1=A1+A1'-diag(diag(A1));
A3=A3+A3'-diag(diag(A3));

A2=binornd(1,q,m,m); %edges +1/-1 nodes

A=[A1 A2; A2' A3];

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

%Solve
opts = struct();
opts.verbosity = 0;  
Q = trustregions(problem,[],opts);

%Find the truth vector
X=Q*Q';
[V,D]=eig(X);
D=diag(D);
g=sqrt(n)*V(:,n);

end