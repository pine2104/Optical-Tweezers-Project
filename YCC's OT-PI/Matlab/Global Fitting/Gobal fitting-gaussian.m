% Gobal fitting
% 2018/7/19 first version by Yen-Chan Chang
% using mininize the total mean square error


clc;clear;close all
sd1=4;
sd2=4;
xm1=0;
xm2=5;
xx=[-sd2*4:0.1:sd2*4];
noise=randn(1,length(xx))/20;
y=@(x,xm,sd) exp(-(x-xm).^2/2/sd^2);
y1=y(xx,xm1,sd1)+noise;
y2=y(xx,xm2,sd2)+noise;

SS1=@(p) sum(((y1-y(xx,p(1),p(2))).^2))
SS2=@(p) sum(((y2-y(xx,p(1),p(2))).^2))
SSS=@(p) SS1([p(1),p(2)])+SS2([p(3),p(2)])
% error1=SS1([0,3])
% error=SSS([0,4,6])
plot(xx,y1,xx,y2)

 a=fminsearch(SSS,[0,4,5])
 
 y1best=y(xx,a(1),a(2));
 y2best=y(xx,a(3),a(2));
 
 figure
plot(xx,y1,xx,y2,xx,y1best,xx,y2best)

