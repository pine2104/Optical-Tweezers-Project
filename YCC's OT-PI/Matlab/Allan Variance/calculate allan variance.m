clc;clear;close all
%load data
name='EQP-2mW-4';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y]=textread(pathname,'%f%f');  
 
%  N=length(y);
%  y1=y(1:N-1);
%  y2=y(2:N);
%  dy=y2-y1;
%  dy2=dy.^2;
data.freq=y;
data.rate=15000;
 n=length(data.freq);
 tau=0.0001:0.001:2
jj=length(tau);
m=floor(tau*data.rate);
 yy=tau.^(-1/2);
 
 for j=1:jj
    % fprintf('.');
        
    D=zeros(1,n-m(j)+1);
    D(1)=sum(data.freq(1:m(j)))/m(j);
    for i=2:n-m(j)+1
        D(i)=D(i-1)+(data.freq(i+m(j)-1)-data.freq(i-1))/m(j);
    end
    
    %standard deviation
    avar.sig(j)=std(D(1:m(j):n-m(j)+1));
    avar.sigerr(j)=avar.sig(j)/sqrt(n/m(j));
    
    %normal Allan deviation 
    avar.sig2(j)=sqrt(0.5*mean((diff(D(1:m(j):n-m(j)+1)).^2)));
    avar.sig2err(j)=avar.sig2(j)/sqrt(n/m(j));
    
    %overlapping Allan deviation
    z1=D(m(j)+1:n+1-m(j));
    z2=D(1:n+1-2*m(j));
    u=sum((z1-z2).^2);
    avar.osig(j)=sqrt(u/(n+1-2*m(j))/2);
    avar.osigerr(j)=avar.osig(j)/sqrt(n-m(j));
 end
loglog(tau,avar.sig2/0.0017,tau,yy*0.33)