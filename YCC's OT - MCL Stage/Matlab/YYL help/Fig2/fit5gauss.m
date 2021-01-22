function [allfraction allcenter allstd]=fit5gauss(c,n,ig)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss5' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
% opts.Lower = [0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5];
% opts.StartPoint = [0.0629270046745775 38 1.74639787580102 0.0584322186263934 32 1.87006360617937 0.0385469718386968 24 3.23314898046635 0.0358198089965644 17 2.10142191843211 0.0269687162753856 8 1.59735843043843];


opts.Lower = [0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5 0 0 3.5];
opts.StartPoint = [0.0762829403606103 38 1.63285140807511 0.0538173607724691 35 2.06546419511986 0.0416088765603329 27 13.8240465368688 0.0370853743664213 18 0.661093133043217 0.0169621317274209 9 1.20693585686677];
opts.Upper = [Inf 40 Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf];


% opts.Lower = [0 30 3.5 0 20 3.5 0 0 3.5 0 0 3.5];
% opts.StartPoint = [0.0632 37.83 3.5 0.05584 32.12 3.6 0.03221 24.19 3.5 0.0106 15.89 3.5];
% opts.Upper = [Inf 45 10 Inf 40 10 Inf 30 10 Inf 20 10];
% Fit model to data.


[fitresult, gof] = fit( xData, yData, ft, opts );
 

 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2:3:14]);
 allstd=allcoeff(1,[3:3:15])/sqrt(2);
 allfraction=allcoeff(1,[1:3:13]).*allstd*sqrt(2*pi);
 