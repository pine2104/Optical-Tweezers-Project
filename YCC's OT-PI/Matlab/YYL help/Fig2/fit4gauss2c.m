function [allfraction allcenter allstd]=fit4gauss2c(c,n,ig)
cE=c;
nE=n;
% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( cE, nE );

% Set up fittype and options.
ft = fittype( 'gauss4' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% opts.Lower = [0 30 3.5 0 20 3.5 0 0 3.5 0 0 3.5];
% opts.StartPoint = [0.03859 33.72 3.657 0.02161 25.1 3.5 0.0284 14.88 3.5 0.073 7.4 3.5];
% opts.Upper = [Inf 45 10 Inf 40 10 Inf 30 10 Inf 40 10];


opts.Lower = [0 30 3.5 0 20 3.5 0 0 3.5 0 0 3.5];
opts.StartPoint = [0.0632 37.83 3.5 0.05584 32.12 3.6 0.03221 24.19 3.5 0.0106 15.89 3.5];
opts.Upper = [Inf 45 10 Inf 40 10 Inf 30 10 Inf 20 10];
% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:11]);
 allstd=allcoeff(1,[3:3:12])/sqrt(2);
 allfraction=allcoeff(1,[1:3:10]).*allstd*sqrt(2*pi);
 