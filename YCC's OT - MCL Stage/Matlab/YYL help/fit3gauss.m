function [allcoeff allcenter allstd]=fit3gauss(c,n,ig)
% % Fit: 'untitled fit 1'.
% [xData, yData] = prepareCurveData( c, n );
% 
% % Set up fittype and options.
% % ft = fittype( 'gauss3' );
% % opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% % opts.Display = 'Off';
% % opts.Lower = [0 0 0 -0 -0 0 -0 -0 0];
% % opts.StartPoint = [0.076140751617991 34 1.86279907734855 0.0705017032358352 26 1.63808946575628 0.05 18 2.93273547792784];
% 
% 
% ft = fittype( 'gauss3' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.Lower = [-Inf 30 0 -Inf -Inf 0 -Inf -Inf 0];
% opts.StartPoint = [0.0987248046071575 35 1.21786317321515 0.0621495582973263 24 1.84117329689736 0.0450536322828106 16.925 3.08162876223794];
% opts.Upper = [Inf 40 Inf Inf Inf Inf Inf Inf Inf];
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts ); 


% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( c, n );

% Set up fittype and options.
ft = fittype( 'gauss3' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 3.5 0 0 3.5 0 10 3.5];
opts.StartPoint = [0.0989782886334611 33.2725 1.4747080692634 0.077876049130069 30.9525 1.80307312960291 0.0522296618708847 25 3.0318847483481];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf 30 Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );



% % Fit: 'untitled fit 1'.
% [xData, yData] = prepareCurveData( c, n );
% 
% % Set up fittype and options.
% ft = fittype( 'a1/c1/2^0.5*exp(-(0.5*(x-b1)/c1)^2) + a2/c2/2^0.5*exp(-0.5*((x-b2)/c2)^2) + (1-a1-a2)/c3/2^0.5*exp(-0.5*((x-b3)/c3)^2)', 'independent', 'x', 'dependent', 'y' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.Lower = [0 0 30 20 10 0 0 0];
% opts.StartPoint = [0.759761306837166 0.334978721835575 35 21 17 3 3 2];
% opts.Upper = [1 1 40 25 20 Inf Inf Inf];
% 
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );


 allcoeff=coeffvalues(fitresult);
 allcenter=allcoeff(1,[2 5 8]);
 allstd=allcoeff(1,[3 6 9])/sqrt(2);