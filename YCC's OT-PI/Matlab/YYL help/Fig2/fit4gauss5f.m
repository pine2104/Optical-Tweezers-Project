function [allfraction allcenter allstd]=fit4gauss5f(c,n,ig)
cE=c;
nE=n;
% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( cE, nE );

% Set up fittype and options.
ft = fittype( 'gauss4' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 38 3.5 0 30 3.5 0 0 3.5 0 0 3.5];
opts.StartPoint = [0.1312 38 1.67167875402716 0.063502182465833 32 2.31568149097373 0.0437 25 1.80148606083763 0.0270144909908264 12 2.8724371149746];
opts.Upper = [Inf 40.5 9 Inf 35 Inf Inf Inf Inf Inf Inf Inf];

% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:11]);
 allstd=allcoeff(1,[3:3:12])/sqrt(2);
 allfraction=allcoeff(1,[1:3:10]).*allstd*sqrt(2*pi);
 