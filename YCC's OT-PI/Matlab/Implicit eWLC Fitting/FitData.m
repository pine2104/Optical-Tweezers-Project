clear;close all
filename='201051-F+U-4500.00-1.00 um s^-1-L-4.69 nm avg step-3281-h300-2-1-raw-Unfolded-eWLC Fitting'
UpperForce=45;
LowerEx=500;
Fshift=-0;
[x F a b c]=textread([filename '.txt']) 
x=abs(x)';
F=abs(F)'+Fshift;

x(F>UpperForce)=[]
F(F>UpperForce)=[]
F(x<LowerEx)=[]
x(x<LowerEx)=[]

fit=lsqcurvefit(@(params, xdata) mWLC(params, xdata),[1200 45 1000], x, F)
plot(x,F,'Marker','diamond','LineStyle','none','Color',[0 0 0])
hold on
Ffit=mWLC(fit,x);
plot(x,Ffit,'LineWidth',1,'Color',[1 0 0])
hold off
x=x';
F=F';
Ffit=Ffit';
