function [g,A,Q,acc]=solve_problems(m,nb,grid)
% function [g,G,Q,D]=solve_problems(m,nb,grid)
%
% For a m fixed, solve the binary SBM (using the function bin_SBM) on nb
% independent trials for each p and q discretized between 0 and 1 according
% to grid.
%
% Inputs :
% - m represents the number of nodes in one class, ie the total number of nodes
%   of the graph is 2*m
% - nb is the number of independent trials (for m, p and q fixed)
%   ran to calculate the accuracy
% - grid is the discretization of the probabilities p and q, i.e. the axes
%   for p and q are divided in grid equally spaced probabilities between 0
%   and 1
%
% Ouputs :
% - g is a n x nb x grid x grid tensor containing vectors of labels 
%   that the algorithm finds for each call to bin_SBM
% - G is a gridx1 cell of cells of size gridxnb containing all random graphs
%   generated at each call to bin_SBM (at each trial of each value taken by
%   p and q)
% - Q is a n x 2 x nb x grid x grid 

n=2*m;

g=zeros(n,nb,grid,grid);
A=zeros(n,n,nb,grid,grid);
Q=zeros(n,2,nb,grid,grid);
acc=zeros(grid,grid);

for p1=1:grid
    for q1=1:grid
        
        %Values of p and q
        p=p1/grid;
        q=q1/grid;
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc1=0; %accuracy for m, p and q fixed
        
        for i=1:nb
            
            [g1,A1,Q1]=bin_SBM(m,p,q); %find the solution using bin_SBM
            if min(norm(x-g1),norm(x+g1))<1e-10
                acc1=acc1+1;
            end
            
            %Store data for one call to bin_SBM
            g(:,i,p1,q1)=g1;
            A(:,:,i,p1,q1)=A1;
            Q(:,:,i,p1,q1)=Q1;
        end
        
        %Compute and store accuracy
        acc1=acc1/nb;
        acc(p1,q1)=acc1;
        
    end
end

end