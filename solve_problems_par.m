function [g,G,Q,acc]=solve_problems_par(m,nb,grid)
% function [g,G,Q,D]=solve_problems(m,nb,grid)
%
% For a m fixed, solve the binary SBM using the function bin_SBM 

n=2*m;
step=1/grid;

g=zeros(n,nb,grid,grid);
G=cell(grid,1);
Q=zeros(n,2,nb,grid,grid);
acc=zeros(grid,grid);

WaitMessage = parfor_wait(grid);

parfor p1=1:grid
    p=p1*(1/grid);
    
    g1=zeros(n,nb,1,grid);
    G1=cell(1,grid);
    Q1=zeros(n,2,nb,1,grid);
    acc1=zeros(1,grid);
    
    for q=step:step:1
        
        indice_q=fix(q*grid);
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc2=0;
        
        for i=1:nb
            [g2,G2,Q2]=bin_SBM(m,p,q); %find the solution using bin_SBM
            if min(norm(x-g2),norm(x+g2))<1e-10
                acc2=acc2+1;
            end
            g1(:,i,1,indice_q)=g2;
            G1{1,indice_q}=G2;
            Q1(:,:,i,1,indice_q)=Q2;
        end
        
        acc2=acc2/nb;
        acc1(1,indice_q)=acc2;
        
    end
    
    g(:,:,p1,:)=g1;
    G{p1,1}=G1;
    Q(:,:,:,p1,:)=Q1;
    acc(p1,:)=acc1;
    
    WaitMessage.Send;
    pause(0.002);
    
end

WaitMessage.Destroy;

end