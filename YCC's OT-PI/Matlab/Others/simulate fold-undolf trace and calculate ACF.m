clc;clear;close all

n=300; % # of data generated
k1=0.5;
k2=0.5;
dt=0.01;
t1=0:dt:1/k1*7;
t2=0:dt:1/k2*7;
p1=k1*exp(-k1*t1); %the prob. density want to generate
p2=k2*exp(-k2*t2); %the prob. density want to generate

cdf1=cumsum(p1)*dt;
cdf2=cumsum(p2)*dt;
% plot(t,cdf)
randomValues1 = rand(1, n);
randomValues2 = rand(1, n);

% inverse interpolation to achieve P(x) -> x projection of the random values
tn1 = interp1(cdf1, t1, randomValues1);
tn2 = interp1(cdf2, t2, randomValues2);

tn1(find(isnan(tn1)))=[];
tn2(find(isnan(tn2)))=[];
% hist(tn,10);
plot(t1,cdf1)
figure
plot(t2,cdf2)
% k5=1/mean(tn);

Fs=200; %Hz
yy=[];
for i=1:min(length(tn1),length(tn2))    
  tt1=[0:1/Fs:tn1(i)];  
  tt2=[0:1/Fs:tn2(i)];
  y1=square(2*pi*tt1/(2*tn1(i)));  %產生dwell time 相同poisson rate
  y2=-square(2*pi*tt2/(2*tn2(i))); 
  yy=[yy y1 y2]; 
     
end
nn=randn(1,length(yy));
yy=yy*10+2*nn;
ty=[1:length(yy)]/Fs;
figure
plot(ty,yy)
nn=500;

% yc=xcorr(yy);
% yc=yc(length(yc)/2:length(yc)/2+200);

% yc=xcov(yy);

yc=autocorr(yy,nn);
yc=yc(2:length(yc));
% tt=linspace(0,nn/Fs,nn+1);
% tt=linspace(1/Fs,nn/Fs,nn);
tt=[0:length(yc)-1]/Fs;
% plot(tt,yy)
mean(tn1)
mean(tn2)
a=log(yc);
figure
plot(tt,yc)

[p r]=Lfit(tt,-log(yc))
% a=a';
% tt=tt';