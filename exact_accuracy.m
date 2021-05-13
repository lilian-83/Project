function acc=exact_accuracy(m,p,q,nb,tol)
% function acc=exact_accuracy(m,p,q,nb)
%
% Returns the empirical accuracy in percentage of exact recovery of the function bin_SBM
% to find the true labels, solving the Binary Stochastic Block Models for 2
% communities using the approach described in the paper of N.Boumal
%
% - m represents the number of nodes in one class, ie the total number of nodes
%   of the graph is 2*m
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge
% - nb is the number of times the algorithm is ran to calculate the accuracy,
%   ie we do a loop of size nb and at each time we see if we recover exactly
%   the true labels. The accuracy is obtained doing a ratio between the
%   number of times the recovery was exact over the total number nb
% - tol is the tolerance under which the recovery is considered as exact
%   (if tol is not precised when calling the function, the default value is
%   1e-10)

if nargin<5
    tol=1e-10;
end

x=[ones(m,1); -ones(m,1)]; %truth

acc=0;

for i=1:nb
    g=bin_SBM(m,p,q); %find the solution using bin_SBM
    if min(norm(x-g),norm(x+g))<tol
        acc=acc+1;
    end
end

acc=acc/nb;

end