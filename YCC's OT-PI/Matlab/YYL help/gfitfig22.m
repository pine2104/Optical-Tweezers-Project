function [center all]=gfitfig2(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,cguess,gstd,gf)
% 
y=@(x,xm,sd) 1/sd/sqrt(2*pi)*exp(-(x-xm).^2/2/sd^2);

% SS1=@(p) sum((y1-gf(1)*y(x1,p(1),gstd(1))).^2); %1 peak
% SS2=@(p) sum((y2-gf(2)*y(x2,p(1),gstd(2))).^2); %1 peak
% SS3=@(p) sum(10000*(y3-gf(3)*y(x3,p(1),gstd(3))).^2+(y3-gf(4)*y(x3,p(2),gstd(4))).^2+(y3-gf(5)*y(x3,p(3),gstd(5))).^2+10000*(y3-gf(6)*y(x3,p(3),gstd(6))).^2); %4 peak
% SS4=@(p) sum((y4-gf(7)*y(x4,p(1),gstd(7))).^2+(y4-gf(8)*y(x4,p(2),gstd(8))).^2+10000*(y4-gf(9)*y(x4,p(3),gstd(9))).^2+(y4-gf(10)*y(x4,p(4),gstd(10))).^2); %4 peak
% SS5=@(p) sum((y5-gf(11)*y(x5,p(1),gstd(11))).^2+10000*(y5-gf(12)*y(x5,p(2),gstd(12))).^2+100*(y5-gf(13)*y(x5,p(3),gstd(13))).^2+(y5-gf(14)*y(x5,p(4),gstd(14))).^2); %4 peak

SS1=@(p) sum((y1-gf(1)*y(x1,p(1),gstd(1))).^2); %1 peak
SS2=@(p) sum((y2-gf(2)*y(x2,p(1),gstd(2))-gf(3)*y(x2,p(2),gstd(3))).^2); %2 peak
SS3=@(p) sum((y3-gf(4)*y(x3,p(1),gstd(4))-gf(5)*y(x3,p(2),gstd(5))-gf(6)*y(x3,p(3),gstd(6))-gf(7)*y(x3,p(3),gstd(7))).^2); %4 peak
SS4=@(p) sum((y4-gf(8)*y(x4,p(1),gstd(8))-gf(9)*y(x4,p(2),gstd(9))-gf(10)*y(x4,p(3),gstd(10))-gf(11)*y(x4,p(4),gstd(11))-gf(12)*y(x4,p(5),gstd(12))).^2); %5 peak
SS5=@(p) sum((y5-gf(13)*y(x5,p(1),gstd(13))-gf(14)*y(x5,p(2),gstd(14))-gf(15)*y(x5,p(3),gstd(15))-gf(16)*y(x5,p(4),gstd(16))-gf(17)*y(x5,p(5),gstd(17))).^2); %5 peak



SSS=@(p) SS1([p(2)])+SS2([p(1) p(2)])+SS3([p(1),p(2),p(3),p(4)])+SS4([p(1) p(2),p(3),p(4),p(5)])+SS5([p(1),p(2),p(3),p(4),p(5)]); %center:p1 p2 p3 p4 p5 
% options = optimset('PlotFcns',@optimplotfval,'TolFun',1e-50,'TolX',1e-50,'MaxIter',2000);
options = optimset('TolFun',1e-10,'MaxIter',200000);
a=fminsearch(SSS,cguess,options);


center=[a(1) a(2) a(3) a(4) a(5)];
all=a;