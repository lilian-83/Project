function partial_recovery(m,p,q,nb)

err=zeros(1,nb);

for i=1:nb
    [~,~,Q,~]=bin_SBM(m,p,q);
    z=randn*Q(:,1)+randn*Q(:,2);
    x=[ones(m,1); -ones(m,1)]; %truth
    err(i)=min(norm(x-z),norm(x+z));
end

plot(1:nb,err);

end