clc
clear
close all

load("results.mat");

m=20;
nb=10;
grid=20;

step=1/grid;

for p=step:step:1
    for q=step:step:1
        scatter(q,p,[],'MarkerEdgeColor',acc(fix(p*grid),fix(q*grid))*[1 1 1],'MarkerFaceColor',acc(fix(p*grid),fix(q*grid))*[1 1 1]);
        hold on;
    end
end

xlim([step 1]);
ylim([step 1]);
xlabel('q');
ylabel('p');
colormap gray;
colorbar;
hold off;