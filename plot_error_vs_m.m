function plot_error_vs_m(max,step,p,q)
% function plot_error_vs_m(max,step,p,q)
%
% Plot the error of the empirical recovery vs the number of nodes in one cluster
% (which is the total number of nodes divided by 2)
% The error is plotted for m between 1 and max with a step of step
%
% - max is the upper bound of the range that m runs through
% - step is the step of the range
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge

error=zeros(1,max/step);

for m=1:step:max
    g=bin_SBM(m,p,q); %find the solution using bin_SBM
    x=[ones(m,1); -ones(m,1)]; %truth
    error(fix(m/step)+1)=min(norm(x-g),norm(x+g)); %stocking the error
end

plot(1:step:max,error)
xlabel('m = number of nodes in one community')
ylabel('Error of the recovery')
grid on

end