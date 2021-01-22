function [allfraction allcenter allstd]=fit2gauss2a(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData(c , n );

% Set up fittype and options.
ft = fittype( 'gauss2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 36 3.5 -Inf -Inf 3.5];
opts.StartPoint = [0.144110275689223 38 1.82359751758746 0.0494091693248253 32 3.26736005789591];
opts.Upper = [Inf 40 Inf Inf Inf Inf];


% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:5]);
 allstd=allcoeff(1,[3:3:6])/sqrt(2);
 allfraction=allcoeff(1,[1:3:4]).*allstd*sqrt(2*pi);

