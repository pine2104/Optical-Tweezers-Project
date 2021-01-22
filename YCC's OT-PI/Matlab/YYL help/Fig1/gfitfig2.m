function [center all]=gfitfig2(x0,y0,x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,cguess)
% 
y=@(x,xm,sd) 1/sd/sqrt(2*pi)*exp(-(x-xm).^2/2/sd^2);
% SS1=@(p) sum((y1-y(x1,p(1),p(2))).^2); %1 peak
% SS2=@(p) sum((y2-y(x2,p(1),p(2))).^2); %1 peak
% SS3=@(p) sum((y3-p(7)*y(x3,p(1),p(2))).^2+(y3-p(8)*y(x3,p(3),p(4))).^2+(y3-(1-p(7)-p(8))*y(x3,p(5),p(6))).^2); %3 peak
% SS4=@(p) sum((y4-p(7)*y(x4,p(1),p(2))).^2+(y4-p(8)*y(x4,p(3),p(4))).^2+(y4-p(9)*y(x4,p(5),p(6))).^2+(y4-(1-p(7)-p(8)-p(9))*y(x4,p(7),p(8))).^2); %4 peak
% SS5=@(p) sum((y5-p(7)*y(x5,p(1),p(2))).^2+(y5-p(8)*y(x5,p(3),p(4))).^2+(y5-p(9)*y(x5,p(5),p(6))).^2+(y5-(1-p(7)-p(8)-p(9))*y(x5,p(7),p(8))).^2); %4 peak
SS0=@(p) sum((y0-y(x0,p(1),3.3)).^2)
SS1=@(p) sum((y1-y(x1,p(1),2.68)).^2); %1 peak
SS2=@(p) sum((y2-y(x2,p(1),3.198)).^2); %1 peak
SS3=@(p) sum((y3-p(4)*y(x3,p(1),4.555)).^2+(y3-p(5)*y(x3,p(2),1.835)).^2+(y3-(1-p(4)-p(5))*y(x3,p(3),2.102)).^2); %3 peak
SS4=@(p) sum((y4-p(5)*y(x4,p(1),3.244)).^2+(y4-p(6)*y(x4,p(2),2.172)).^2+(y4-p(7)*y(x4,p(3),3.942)).^2+(y4-(1-p(5)-p(6)-p(7))*y(x4,p(4),1.792)).^2); %4 peak
SS5=@(p) sum((y5-p(5)*y(x5,p(1),2.789)).^2+(y5-p(6)*y(x5,p(2),1.569)).^2+(y5-p(7)*y(x5,p(3),1.556)).^2+(y5-(1-p(5)-p(6)-p(7))*y(x5,p(4),2.022)).^2); %4 peak



% SSS=@(p) SS1([p(1),p(2)])+SS2([p(1),p(3)])+SS3([p(1),p(4),p(5),p(6),p(7),p(8),p(18),p(19)])+SS4([p(1),p(9),p(5),p(10),p(7),p(11),p(12),p(13),p(20),p(21),p(22)])+SS5([p(1),p(14),p(5),p(15),p(7),p(16),p(12),p(17),p(23),p(24),p(25)]); %center:p1 p5 p7 p12 

SSS=@(p) SS0([p(1)])+SS1([p(1)])+SS2([p(1)])+SS3([p(1),p(2),p(3),p(4),p(5)])+SS4([p(1),p(2),p(3),p(6),p(7),p(8),p(9)])+SS5([p(1),p(2),p(3),p(6),p(10),p(11),p(12)]); %center:p1 p2 p3 p6

% options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-10,'MaxIter',2000);
options = optimset('TolFun',1e-5,'MaxIter',2000);
a=fminsearch(SSS,cguess,options);


center=[a(1) a(2) a(3) a(6)];
all=a;