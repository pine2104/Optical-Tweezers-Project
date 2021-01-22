function [center std]=figplot(x,y,cguess)
cA=x;
nA=y;
g=@(x,p) p(1)*exp(-(x-p(2)).^2/p(3)^2);

%
[xData, yData] = prepareCurveData( cA, nA );
% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = cguess;

% Fit model to data.
[fitresultA, gofA] = fit( xData, yData, ft, opts );
coeffA=coeffvalues(fitresultA);
centerA=coeffA(1,2);
stdA=coeffA(1,3)/sqrt(2);
xA=[centerA-5*stdA:0.1:centerA+5*stdA];


% bar(cA,nA,'LineWidth',1.5,...
%     'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
%     'BarWidth',1);
hold on
plot(xA,g(xA,coeffA),'r')
hold off
ftype(1)
center=centerA
std=stdA
