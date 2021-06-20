function c=correlation(m,nb,grids)

n=2*m;

WaitMessage = parfor_wait(grids);

a=linspace(0,30,grids);
b=linspace(0,10,grids);

c=zeros(grids,grids);

parfor i=1:grids
    
    %Value of p
    p=alpha(i)*log(n)/n;
    
    c1=zeros(1,grids);
    
    for j=1:grids
        
        %Value of q
        q=beta(j)*log(n)/n;
        
        g=[ones(m,1); -ones(m,1)]; %truth
        
        av=0; %average of non-trivial correlations
        
        for k=1:nb
            [~,~,Q,~]=bin_SBM(m,p,q);
            av=av+norm(Q'*g)/n;
        end
        
        %Compute and store correlation
        av=av/nb;
        c1(1,j)=av;
        
    end
    
    c(i,:)=c1;
    
    WaitMessage.Send;
    pause(0.002);
    
end

WaitMessage.Destroy;

end