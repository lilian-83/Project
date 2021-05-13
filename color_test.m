clc;
clear;
close all;

subdivision=10;
step=1/subdivision;

for p=step:step:1
    for q=step:step:1
        scatter(p,q,[],'MarkerEdgeColor',p*q*[1 1 1],'MarkerFaceColor',p*q*[1 1 1]);
        hold on;
    end
end

xlim([0.1 1]);
colormap gray;
colorbar;
grid on;