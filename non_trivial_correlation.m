function [av,triv]=non_trivial_correlation(m,p,q,nb)
%Compare a trivial correlation with the non trivial correlation

n=2*m; %total number of nodes

g=[ones(m,1);-ones(m,1)]; %truth
z=g(randperm(2*m));
triv=z'*g/n; %trivial correlation ?

av=0; %average of non-trivial correlations
for i=1:nb
    [g,~,Q,~]=bin_SBM(m,p,q);
    av=av+norm(Q'*g)/n;
end
av=av/nb;

end