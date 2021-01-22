function [allfraction allcenter allstd]=fit1gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [0.0989782886334611 33.2725 4.42412420779021];


% opts.Lower = [0 30 3.5 0 20 3.5 0 0 3.5 0 0 3.5];
% opts.StartPoint = [0.0632 37.83 3.5 0.05584 32.12 3.6 0.03221 24.19 3.5 0.0106 15.89 3.5];
% opts.Upper = [Inf 45 10 Inf 40 10 Inf 30 10 Inf 20 10];
% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,2);
 allstd=allcoeff(1,3)/sqrt(2);
 allfraction=allcoeff(1,1).*allstd*sqrt(2*pi);
 