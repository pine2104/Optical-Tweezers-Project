y=z_hat{1,5};
state=max(y); %how many states?

for i= 1:state
    a=find(y==i)
    bp=0
    count=1
    for ii=1:length(a)-1        
        if a(ii)+1~=a(ii+1)
            bp=bp+1            
            tn(bp,i)=count;
            count=1;
        else
            count=count+1
        end
    end
end