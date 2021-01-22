clc;clear;close all

%load data
name='stage-x-test-100kpoints-3.75kHz-0516-1';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x]=textread(pathname,'%f');  
x=x'*1000; %nm
 n=length(x); 
data.rate=3750; %Hz
data.freq=x; % nm

tau=0.0005:0.0005:1; %s
jj=length(tau);
m=floor(tau*data.rate);
 
 for j=1:jj
    % fprintf('.');
        
    D=zeros(1,n-m(j)+1);
    D(1)=sum(data.freq(1:m(j)))/m(j);
    for i=2:n-m(j)+1
        D(i)=D(i-1)+(data.freq(i+m(j)-1)-data.freq(i-1))/m(j);
    end  
    
%     %standard deviation
%     avar.sig(j)=std(D(1:m(j):n-m(j)+1));
%     avar.sigerr(j)=avar.sig(j)/sqrt(n/m(j));
%     
%     %normal Allan deviation 
%     avar.sig2(j)=sqrt(0.5*mean((diff(D(1:m(j):n-m(j)+1)).^2)));
%     avar.sig2err(j)=avar.sig2(j)/sqrt(n/m(j));
    
    %overlapping Allan deviation
    z1=D(m(j)+1:n+1-m(j));
    z2=D(1:n+1-2*m(j));
    u=sum((z1-z2).^2);
    avar.osig(j)=sqrt(u/(n+1-2*m(j))/2);
    avar.osigerr(j)=avar.osig(j)/sqrt(n-m(j));
 end
loglog(tau*1000,avar.osig)
xlabel('average time (ms)')
ylabel('position (um)')