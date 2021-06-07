function [g,G,Q,acc]=solve_problems_regime_par(m,nb,grids)
% function [g,A,Q,D]=solve_problems(m,nb,grid)
%
% For a m fixed, solve the binary SBM (using the function bin_SBM) on nb
% independent trials for each p and q discretized between 0 and 1 according
% to grid. Uses a parfor loop for p to speed up calculations.
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
G=cell(1,grids);
Q=zeros(n,2,nb,grids,grids);
acc=zeros(grids,grids);

WaitMessage = parfor_wait(grids);

alpha=linspace(0,30,grids);
beta=linspace(0,10,grids);

parfor i=1:grids
    
    %Value of p
    p=alpha(i)*log(n)/n;
    
    %Initialize tensors because we cannot store directly in what is declared before
    %a parfor loop
    g1=zeros(n,nb,grids);
    G1=cell(grids,nb);
    Q1=zeros(n,2,nb,grids);
    acc1=zeros(1,grids);
    
    for j=1:grids
        
        %Value of q
        q=beta(j)*log(n)/n;
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc2=0; %accuracy for m, p and q fixed
        
        for k=1:nb
            
            [g2,A,Q2]=bin_SBM(m,p,q); %find the solution using bin_SBM
            G2=graph(A);
            if min(norm(x-g2),norm(x+g2))<1e-10
                acc2=acc2+1;
            end
            
            %Store data for one call to bin_SBM
            g1(:,k,j)=g2;
            G1{j,k}=G2;
            Q1(:,:,k,j)=Q2;
            
        end
        
        %Compute and store accuracy
        acc2=acc2/nb;
        acc1(1,j)=acc2;
        
    end
    
    %After one loop of the parfor loop, store all data in what was declared
    %before the parfor loop
    g(:,:,i,:)=g1;
    G{i}=G1;
    Q(:,:,:,i,:)=Q1;
    acc(i,:)=acc1;
    
    WaitMessage.Send;
    pause(0.002);
    
end

WaitMessage.Destroy;

end