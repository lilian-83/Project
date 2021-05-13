function phase_transition_plot(m,nb,grid)
% function phase_transition(m,nb,grid)
%
% Plot in 2D the empirical accuracy rate for different values of p and q (p
% on the y-axis and q on the x-axis) when solving the binary SBM with the
% approach described in the paper of N.Boumal. To show the accuracy a black
% gradation is used : the lighter, the higher the accuracy. This function
% calls exact_accuracy for p and q that ranges between 0 and 1 on a grid
% (see the parameter grid)
%
% - m represents the number of nodes in one class, ie the total number of nodes
%   of the graph is 2*m
% - nb is the number of independent trials used to calculate the empirical
%   success rate
% - grid is the number of p and q that we consider on each axes (equally
%   spaced)
%
% Reminder :
% - p represents the probability that two nodes of the same class are connected
%   by an edge
% - q represents the probability that two nodes of differents classes are connected
%   by an edge

step=1/grid;

for p=step:step:1
    for q=step:step:1
        acc=exact_accuracy(m,p,q,nb);
        scatter(q,p,[],'MarkerEdgeColor',acc*[1 1 1],'MarkerFaceColor',acc*[1 1 1]);
        hold on;
    end
end

xlim([step 1]);
xlabel('q');
ylabel('p');
colormap gray;
colorbar;
hold off;

end