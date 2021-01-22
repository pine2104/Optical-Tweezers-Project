function [allfraction allcenter allstd]=fit4gauss3ca(c,n,ig)
cE=c;
nE=n;
% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( cE, nE );

% Set up fittype and options.
ft = fittype( 'gauss4' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5];
opts.StartPoint = [0.0987248046071575 38 0.91339737991136 0.0655334008927328 32 1.28574871205955 0.0452483855992113 25 2.09246198018104 0.0287947346770876 17 2.68087638263273];

% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:11]);
 allstd=allcoeff(1,[3:3:12])/sqrt(2);
 allfraction=allcoeff(1,[1:3:10]).*allstd*sqrt(2*pi);
 