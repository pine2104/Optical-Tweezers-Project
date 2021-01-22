clc;clear;close all
x=[-5:0.01:5];
y=-normpdf(x,0,2);
for i=1:(length(x)-1);
    dy(i)=y(i+1)-y(i);
end
plot(x,y)
% plot(x(1:(length(x)-1)),dy)

