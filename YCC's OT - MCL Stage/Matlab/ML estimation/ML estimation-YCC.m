% clc;clear;close all
    gtau=mean(tn);
    kexp=1/gtau;
    n=200;
    
    for i=1:n %try n次
        tau(i)=gtau-20+40*i/n;
        k(i)=1/tau(i); % try k
        p2=log(k(i)*exp(-k(i)*tn)); % 在time=tn時, 成功之機率
        ML(i)=-sum(p2);
        end
    
[Y I]=min(ML);
kML=k(I); 
plot(tau,ML);

% [n c]=hist(tn,20);
% n=n/sum(n);
% p2=1-(cumsum(n));
% plot(c,p2)

