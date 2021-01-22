function [allfraction allcenter allstd]=fit7gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss7' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 2.2 0 0 2.2 0 0 2.2 0 0 2.2 0 0 2.2 0 0 2.2 0 0 2.2];
opts.StartPoint = [0.052075799218863 55 1.08721546725724 0.046289599305656 45 1.62752618547512 0.0334873200610882 35 2.00760926497126 0.0260378996094315 25 1.89869602425857 0.0250018254350584 19 2.60823011019387 0.0242268852119068 12 2.56834561387533 0.023144799652828 7 3.38650820290142];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf 20 Inf Inf 10 Inf];


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:20]);
 allstd=allcoeff(1,[3:3:21])/sqrt(2);
 allfraction=allcoeff(1,[1:3:19]).*allstd*sqrt(2*pi);
 