function [center all]=gfitfig1TG(x1,y1,x2,y2,cguess)
% 
y=@(x,xm,sd) 1/sd/sqrt(2*pi)*exp(-(x-xm).^2/2/sd^2);
SS1=@(p) sum((y1-y(x1,p(1),3.282)).^2); %1 peak
% SS2=@(p) sum((y2-p(4)*y(x2,p(1),4.55518)).^2+(y2-p(5)*y(x2,p(2),1.834942)).^2+(y2-(1-p(4)-p(5))*y(x2,p(3),2.101521354)).^2); %3 peak
SS2=@(p) sum((y2-0.792671557*y(x2,p(1),4.55518)).^2+(y2-0.144236662*y(x2,23.63,1.834942)).^2+(y2-0.063091781*y(x2,16.18,2.101521354)).^2); %3 peak


SSS=@(p) SS1([p(1)])+SS2([p(1)]) %center: p1 p2 p3
% options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-50,'MaxIter',5000);
options = optimset('TolFun',1e-10,'MaxIter',20000);
a=fminsearch(SSS,cguess,options);


center=[a(1)];
all=a;