function plot_accuracy_vs_m(max,step,p,q,nb,tol)
% function plot_accuracy_vs_m(max,step,p,q,nb,tol)
%
% Plot the empirical accuracy of the recovery vs the number of nodes in one cluster 
% using the function exact_accuracy
%
% - max is the upper bound of the range that m runs through
% - step is the step of the range
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge
% - nb is the number of times the algorithm is ran to calculate the
%   accuracy, used in the call of exact_accuracy (see exact_accuracy for more
%   details)
% - tol is the tolerance under which the recovery is considered as exact
%   (if tol is not precised when calling the function, the default value is
%   the default value of exact_accuracy

acc=zeros(1,max/step);

for m=1:step:max
    if nargin<6
        acc((fix(m/step)+1))=exact_accuracy(m,p,q,nb);
    else
        acc((fix(m/step)+1))=exact_accuracy(m,p,q,nb,tol);
    end
end

plot(1:step:max,acc);
xlabel('m = number of nodes in one community')
ylabel('Accuracy of the recovery')
grid on

end