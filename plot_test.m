%

clc
clear
close all

load("results.mat");

for p=1:grid
    for q=1:grid
        scatter(q/grid,p/grid,[],'MarkerEdgeColor',acc(p,q)*[1 1 1],'MarkerFaceColor',acc(p,q)*[1 1 1]);
        hold on;
    end
end

xlim([1/grid 1]);
ylim([1/grid 1]);
xlabel('q');
ylabel('p');
colormap gray;
colorbar;
hold off;