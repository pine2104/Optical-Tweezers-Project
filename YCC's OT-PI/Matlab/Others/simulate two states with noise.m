clc;clear;close all
%     a=10*randn(1);
%     b=10*randn(1);
%     n=abs(round(a))
%     T=abs(round(b))
%     x=1:0.05:100
%     n2=round(length(x)/n)
%     y=square(2*pi*x(1:n2)/T)
%     plot(x(1:n2),y)
%     axis([0 100 -2 2])
xx=1:0.1:20;
    y=zeros(length(xx)-1,5);
    for i=1:10        
        a=1*randn(1);
        b=3*randn(1);
        n=abs(round(a))+1; % # of period
        T=abs(round(b))+1; 
        x=[0:0.04:n*T];
%         n2=round(length(x)/n);
        y(1:length(x)-1,i)=square(2*pi*x(1:(length(x)-1))/T);        
    end
    
%     a1=y(1,:);
%     ai=find(a1==0);
%     a1(ai)=[];

    yy=y(:);    
    yy(find(y==0))=[];
    yyn=yy+0.2*randn(length(yy),1)
    plot(yyn,'b-')
    axis([0 100 -1.5 1.5])
% %     plot(y)