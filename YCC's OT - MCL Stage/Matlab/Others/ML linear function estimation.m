clc;clear;close all
power=[20
40
60
80
100
120
];
k=[0.07513248
0.141418625
0.2148858
0.2936162
0.365632167
0.435469
];
format long
yi=@(a,b,x) a*x+b
l=@(p) -sum(log(exp(-(k-yi(p(1),p(2),power)).^2/2/2^2)));   %p(1):slope, p(2):intercept, p(3):std

options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-30,'MaxIter',2000);
r=fminsearch(l,[0.1036,0],options)

figure
plot(power,k,'o',power,r(1)*power+r(2))


% fminbnd
