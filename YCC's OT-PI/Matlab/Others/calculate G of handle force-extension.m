clc;clear;close all
x=[0:0.1:550]*10^(-9);
x2=[0:0.1:550];
x3=[0:0.1:900]*10^-9;
x4=x3*10^9;
lp=43*10^(-9);
l=600*10^-9;
kb=1.38*10^(-23);
T=298.15;
g=l*(3*(x/l).^2-2*(x/l).^3)./(lp*4*(1-x/l));
plot(x2,g)
xlabel('extension (nm)')
ylabel('k_BT')
grid on
