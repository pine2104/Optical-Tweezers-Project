clc;clear;close all
x=8:0.05:18;
s1=0.5;
s2=0.5;
y1=1/(s1*sqrt(2*pi))*exp(-((x-11)/(2*s1^2)).^2);
y2=1/(s2*sqrt(2*pi))*exp(-((x-15)/(2*s2^2)).^2);
y=y1+y2;

xp=-5:0.05:5;
sp=0.8;
psf=1/(sp*sqrt(2*pi))*exp(-((xp)/(2*sp^2)).^2);

plot(x,y1,x,y2)
figure

plot(xp,psf)
xP=3:0.05:23
P=conv(y,psf);
figure
plot(xP,P)
axis([8 18 0 8])
psf(100)=0.49;
[yd r]=deconv(P,psf);
figure
plot(x,yd)
axis([8 18 0 0.8])
