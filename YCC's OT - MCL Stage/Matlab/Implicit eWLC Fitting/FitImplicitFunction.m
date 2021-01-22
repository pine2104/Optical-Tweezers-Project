
xx=linspace(-30, 30, 200); % magnetic field
p=[10, 2, 0.1]; %parameters
yy=LangevinWithWeissField(p, xx)+3*rand(1,length(xx)); % magnetization values
plot(xx, yy, '*-r'); % plot
% 
% Now let's see how to "fit" the y-data we just created, i.e. the vector yy.
% I use the  LSQCURVEFIT function as done in this mathworks' link.
% The code to use in the command line is

lsqcurvefit(@(params, xdata) LangevinWithWeissField(params, xdata),[1 1 1], xx, yy)
