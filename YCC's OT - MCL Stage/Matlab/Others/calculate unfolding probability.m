clc;clear;close all
kb=1.38*10^(-23);
T=298.15;
Fhalf=13.2*10^-12;
dx=18*10^-9;
F=[11:0.1:16]*10^-12;
F2=F*10^12
Pu=1./(1+exp((Fhalf-F)*dx/(kb*T)));
plot(F2,Pu)
xlabel('Force (pN)')
ylabel('open prob.')
grid on