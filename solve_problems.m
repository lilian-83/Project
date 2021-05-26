function [g,G,Q,X,D,acc]=solve_problems(m,nb,grid)
% function [g,G,Q,D]=solve_problems(m,nb,grid)
%
% For a m fixed, solve the binary SBM using the function bin_SBM 

n=2*m;
step=1/grid;

g=zeros(n,nb,grid,grid);
G=cell(grid,grid);
Q=zeros(n,2,nb,grid,grid);
X=zeros(n,n,nb,grid,grid);
D=zeros(n,grid,grid);
acc=zeros(grid,grid);

for p=step:step:1
    for q=step:step:1
        
        indice_p=fix(p*grid);
        indice_q=fix(q*grid);
        
        x=[ones(m,1); -ones(m,1)]; %truth
        acc1=0;
        
        for i=1:nb
            [g1,G1,Q1,X1,D1]=bin_SBM(m,p,q); %find the solution using bin_SBM
            if min(norm(x-g1),norm(x+g1))<1e-10
                acc1=acc1+1;
            end
            g(:,i,indice_p,indice_q)=g1;
            G{indice_p,indice_q}=G1;
            Q(:,:,i,indice_p,indice_q)=Q1;
            X(:,:,i,indice_p,indice_q)=X1;
            D(:,indice_p,indice_q)=D1;
        end
        
        acc1=acc1/nb;
        acc(indice_p,indice_q)=acc1;
        
    end
end

end