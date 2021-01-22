clc;clear;close all
fs=30; %Hz
n=500; %# of data generated
tmax=150; %Æ[¹î®É¶¡
k=0.05;
dt=0.1;
t=0:dt:tmax;
p=k*exp(-k*t); %the prob. density want to generate
cdf=cumsum(p)*dt;
% plot(t,cdf)
randomValues = rand(1, n);

% inverse interpolation to achieve P(x) -> x projection of the random values
tn = interp1(cdf, t, randomValues);
tn(find(isnan(tn)))=[];
% hist(tn,10);
plot(t,cdf)
% k5=1/mean(tn);
