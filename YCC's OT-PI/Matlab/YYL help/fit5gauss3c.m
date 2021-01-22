function [allfraction allcenter allstd]=fit5gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss5' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

opts.Lower = [0 0 3.3 0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5];
opts.StartPoint = [0.0699637063273427 38 3.5 0.0567170551635117 33 3.5 0.0472710214746985 27 3.5 0.0349818531636713 18 3.78407693855178 0.0313147140221616 9 2.95762535953198];
opts.Upper = [Inf 40 10 Inf Inf 10 Inf Inf Inf Inf Inf Inf 10 Inf Inf];


% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:14]);
 allstd=allcoeff(1,[3:3:15])/sqrt(2);
 allfraction=allcoeff(1,[1:3:13]).*allstd*sqrt(2*pi);
 