clc;clear;close all
x=700:1:1050;
p=[1000,45,1200];
force=mWLC(p,x);

% exn=ex+5*randn(1,length(ex));
forcen=force+randn(1,length(x));

% 
% plot(ex,forcen,'ko')

% The code to use in the command line is

fit=lsqcurvefit(@(params, xdata) mWLC(params, xdata),[1000 45 1200], x, forcen)

forcefit=mWLC(fit,x);

plot(x,forcen,'ko')
hold on
plot(x,forcefit)


% forcefit=@(x,f,lc,lp,K) 4.1/lp*(1/4.*((1-x/lc+f/K)).^(-2)-0.25+x/lc-f/K)
% f=@(p,exdata) 4.1/p(2)*(1/4.*((1-exdata/p(1)+f/p(3))).^(-2)-0.25+exdata/p(1)-f/p(3))
% aa=lsqcurvefit(@(p,exdata) 4.1/p(2)*(1/4.*((1-exdata/p(1)+f/p(3))).^(-2)-0.25+exdata/p(1)-f/p(3)),[1000 50 1200],exn,force)

% SS=@(p) sum((forcefit(ex,f,p(1),p(2),p(3))-f).^2)
% 
% options = optimset('PlotFcns',@optimplotfval);
% 
% pfit=fminsearch(SS,[1000 45 1200],options)