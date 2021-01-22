function [allfraction allcenter allstd]=fit6gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss6' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf -Inf 0 -Inf 15 0 -Inf 10 0];
opts.StartPoint = [0.0479202606862181 55 1.83159251557737 0.0440866398313207 45 1.35564142130267 0.0304018040431596 35 1.97083064381666 0.023347496493453 25 4.32644935052582 0.0230017251284084 19 5 0.021084914701936 13 3.02059452788534];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf 25 10 Inf 15 Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

  allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:17]);
 allstd=allcoeff(1,[3:3:18])/sqrt(2);
 allfraction=allcoeff(1,[1:3:16]).*allstd*sqrt(2*pi);
