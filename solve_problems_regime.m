function [g,G,Q,acc]=solve_problems_regime(m,nb,grids)
% function [g,A,Q,D]=solve_problems(m,nb,grid)
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

g=zeros(n,nb,grids,grids);
G=cell(nb,grids,grids);
Q=zeros(n,2,nb,grids,grids);
acc=zeros(grids,grids);

WaitMessage = parfor_wait(grids);

alpha=linspace(0,30,grids);
beta=linspace(0,10,grids);

for i=1:grids
    
    %Value of p
    p=alpha(i)*log(n)/n;
    
    for j=1:grids
        
        %Value of q
        q=beta(j)*log(n)/n;
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc1=0; %accuracy for m, p and q fixed
        
        for k=1:nb
            
            [g1,A,Q1]=bin_SBM(m,p,q); %find the solution using bin_SBM
            G1=graph(A);
            if min(norm(x-g1),norm(x+g1))<1e-10
                acc1=acc1+1;
            end
            
            %Store data for one call to bin_SBM
            g(:,k,i,j)=g1;
            G{k,i,j}=G1;
            Q(:,:,k,i,j)=Q1;
        end
        
        %Compute and store accuracy
        acc1=acc1/nb;
        acc(i,j)=acc1;
        
    end
    
    WaitMessage.Send;
    pause(0.002);
    
end

WaitMessage.Destroy;

end