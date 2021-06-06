function [g,A,Q,acc]=solve_problems_par(m,nb,grid)
% function [g,G,Q,D]=solve_problems_par(m,nb,grid)
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
% - A is a gridx1 cell of cells of size gridxnb containing all random graphs
%   generated at each call to bin_SBM (at each trial of each value taken by
%   p and q)
% - Q is a n x 2 x nb x grid x grid 

n=2*m;

%Initializing tensors that will contain the data
g=zeros(n,nb,grid,grid);
A=zeros(n,n,nb,grid,grid);
Q=zeros(n,2,nb,grid,grid);
acc=zeros(grid,grid);

% WaitMessage = parfor_wait(grid); %to have a waitbar during the execution of
% the parfor loop (see parfor_wait.m for more details)

parfor p1=1:grid
    p=p1/grid; %value of p
    
    %Initialize tensors because we cannot store directly in what is declared before
    %a parfor loop
    g1=zeros(n,nb,grid);
    A1=zeros(n,n,nb,grid);
    Q1=zeros(n,2,nb,grid);
    acc1=zeros(1,grid);
    
    for q1=1:grid
        q=q1/grid; %value of q
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc2=0; %accuracy for m, p and q fixed
        
        for i=1:nb
            
            [g2,A2,Q2]=bin_SBM(m,p,q); %find the solution using bin_SBM
            if min(norm(x-g2),norm(x+g2))<1e-10
                acc2=acc2+1;
            end
            
            %Store the data for one call to bin_SBM
            g1(:,i,q1)=g2;
            A1(:,:,i,q1)=A2;
            Q1(:,:,i,q1)=Q2;
        end
        
        %Calculate and store accuracy
        acc2=acc2/nb;
        acc1(1,q1)=acc2;
        
    end
    
    %After one loop of the parfor loop, store all data in what was declared
    %before the parfor loop
    g(:,:,p1,:)=g1;
    A(:,:,:,p1,:)=A1;
    Q(:,:,:,p1,:)=Q1;
    acc(p1,:)=acc1;
    
%     WaitMessage.Send; %vizualize the progress of the loop with some 
    %information about time used
%     pause(0.002);
    
end

% WaitMessage.Destroy;

end