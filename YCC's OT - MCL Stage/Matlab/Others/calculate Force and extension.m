clc;clear
close all
bps=2451;
n=1;
P=45; %persistence length (nm)
L0=0.34*bps; %contour length (nm)
% x=520; %DNA length (nm)
u=-L0+50:0.05:L0-50; %generate DNA length (nm)
F=4.08687*(n/P).*(sign(u).*1/4.*(1-sign(u).*u/L0).^(-2)-(1/4.*sign(u))+u./L0+(-0.5164228).*((u./L0).^(2)).*sign(u)+(-2.737418).*((u./L0).^(3))+(16.07497)*((u./L0).^(4)).*sign(u)+(-38.87607)*((u./L0).^(5))+(39.49944)*((u./L0).^(6)).*sign(u)+(-14.17718).*((u./L0).^(7)));
plot(u,F)
xlabel('extension (nm)','FontSize',10);
ylabel('Force (pN)','FontSize',10);
axis([-L0 L0 -10 10])