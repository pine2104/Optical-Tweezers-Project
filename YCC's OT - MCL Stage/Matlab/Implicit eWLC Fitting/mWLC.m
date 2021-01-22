function f=mWLC(p, x)
lc=p(1);
lp=p(2);
K=p(3);

force=0.1:0.05:100;
o=@(f) lc*(1-0.5*sqrt(4.1).*(f*lp).^(-0.5)+f/K);
exo=o(force);
h=@(x) 4.1/lp*(1/4./((1-x/lc)).^2-0.25+x/lc);
opt = optimset('display','off');
for i=1:length(x) 
%           F(i)=fsolve(@(ff) 4.1/lp*(1/4.*((1-x(i)/lc+ff/K)).^(-2)-0.25+x(i)/lc-ff/K)-ff , 0.1, opt);  
        g=@(f) 4.1/lp*(1/4.*((1-x(i)/lc+f/K)).^(-2)-0.25+x(i)/lc-f/K)-f;
        [minValue,closestIndex] = min(abs(exo-x(i)));
        closestValue(i) = force(closestIndex);
        F(i)=fzero(g,closestValue(i));    

    end
        
% plot(x,F,'k')
% hold on
% plot(x,h(x))
% plot(exo,force,'r')
% hold off
% 
% ylim([0 5])
% xlim([700 950])
% extension=x;
f=F;

end