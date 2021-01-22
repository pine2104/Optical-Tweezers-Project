clc;clear;close all
fs=30; %Hz
n=300; % # of data generated
tmax=100; %Æ[¹î®É¶¡
k=10;
dt=0.001;
t=0:dt:tmax;
p=1/(k*sqrt(2*pi))*exp(-(t-50).^2/(2*(k^2)));
cdf=cumsum(p)*dt;
plot(t,cdf)
randomValues = rand(1, 200);

% inverse interpolation to achieve P(x) -> x projection of the random values
tn = interp1(cdf, t, randomValues);
tn(find(isnan(tn)))=[];
% hist(tn,10);
plot(t,cdf)
% k5=1/mean(tn);
