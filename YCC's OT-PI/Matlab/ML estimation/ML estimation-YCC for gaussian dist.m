% clc;clear;close all

    kexp=10-5;
    n=200;
    
    for i=1:n %try n次
        k(i)=kexp+10*i/n; % try k
        p2=log((1./(k(i)*sqrt(2*pi)))*exp(-(tn-50).^2/(2*(k(i).^2)))); % 在time=tn時, 成功之機率
        ML(i)=-sum(p2);
        end
    
[Y I]=min(ML);
kML=k(I); 
plot(k,ML);



