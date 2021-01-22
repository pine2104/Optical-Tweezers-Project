function [allfraction allcenter allstd]=fit2gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData(c , n );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 35 3.5 -Inf 0 3.5];
opts.StartPoint = [0.0989782886334611 38 2.2120621038951 0.0532589394711353 33 3.33860706349251];
opts.Upper = [Inf 45 10 Inf Inf 10];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:5]);
 allstd=allcoeff(1,[3:3:6])/sqrt(2);
 allfraction=allcoeff(1,[1:3:4]).*allstd*sqrt(2*pi);

