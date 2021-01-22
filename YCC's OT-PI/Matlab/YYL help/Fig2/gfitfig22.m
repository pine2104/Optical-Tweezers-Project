function [center all]=gfitfig2(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,cguess,gstd,gf)
% 
y=@(x,xm,sd) 1/sd/sqrt(2*pi)*exp(-(x-xm).^2/2/sd^2);



SS1=@(p) sum((y1-gf(1)*y(x1,p(1),gstd(1))-gf(2)*y(x1,p(2),gstd(2))).^2); %2 peak
SS2=@(p) sum((y2-gf(3)*y(x2,p(1),gstd(3))-gf(4)*y(x2,p(2),gstd(4))).^2); %2 peak
SS3=@(p) sum((y3-gf(5)*y(x3,p(1),gstd(5))-gf(6)*y(x3,p(2),gstd(6))-gf(7)*y(x3,p(3),gstd(7))-gf(8)*y(x3,p(3),gstd(8))).^2); %4 peak
SS4=@(p) sum((y4-gf(9)*y(x4,p(1),gstd(9))-gf(10)*y(x4,p(2),gstd(10))-gf(11)*y(x4,p(3),gstd(11))-gf(12)*y(x4,p(4),gstd(12))-gf(13)*y(x4,p(5),gstd(13))).^2); %5 peak
SS5=@(p) sum((y5-gf(14)*y(x5,p(1),gstd(14))-gf(15)*y(x5,p(2),gstd(15))-gf(16)*y(x5,p(3),gstd(16))-gf(17)*y(x5,p(4),gstd(17))-gf(18)*y(x5,p(5),gstd(18))).^2); %5 peak
SSf3=@(p) sum((y6-gf(19)*y(x6,p(1),gstd(19))-gf(20)*y(x6,p(2),gstd(20))-gf(21)*y(x6,p(3),gstd(21))-gf(22)*y(x6,p(3),gstd(22))).^2); %4 peak
SSf5f=@(p) sum((y7-gf(23)*y(x7,p(1),gstd(23))-gf(24)*y(x7,p(2),gstd(24))-gf(25)*y(x7,p(3),gstd(25))-gf(26)*y(x7,p(3),gstd(26))).^2); %4 peak

SSS=@(p) SS1([p(1) p(2)])+SS2([p(1) p(2)])+SS3([p(1),p(2),p(3),p(4)])+SS4([p(1) p(2),p(3),p(4),p(5)])+SS5([p(1),p(2),p(3),p(4),p(5)])+SSf3([p(1),p(2),p(3),p(4)])+SSf5f([p(1),p(2),p(3),p(4)]); %center:p1 p2 p3 p4 p5 
% options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-50,'TolX',1e-50,'MaxIter',2000);
options = optimset('TolFun',1e-10,'MaxIter',200000);
a=fminsearch(SSS,cguess,options);


center=[a(1) a(2) a(3) a(4) a(5)];
all=a;