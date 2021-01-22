function [center std]=figplot(x1,y1,x2,y2,cguess)

y=@(x,xm,sd) 1/sd/sqrt(2*pi)*exp(-(x-xm).^2/2/sd^2);


SS1=@(p) sum(((y1-y(x1,p(1),p(2))).^2))
SS2=@(p) sum(((y2-y(x2,p(1),p(2))).^2))


SSS=@(p) SS1([p(1),p(2)])+SS2([p(1),p(3)])


 a=fminsearch(SS1,[35,2.9,2.5])


  
 xA=[a(1)-5*a(2):0.1:a(1)+5*a(2)];
 xB=[a(1)-5*a(3):0.1:a(1)+5*a(3)];
 y1best=y(xA,a(1),a(2));
 y2best=y(xB,a(1),a(3));
 
  figure
  bar(x1,y1,'LineWidth',1.5,...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'BarWidth',1);
% plot(x1,y1,x2,y2,x1,y1best,'o',x2,y2best,'o')

hold on
h=plot(xA,y1best,'r')
% xlabel('BM (nm)','FontWeight','bold','FontName','Arial');
% ylabel('Frequency','FontWeight','bold','FontName','Arial');
%      ax = gca;
%      ax.XAxis.MinorTick = 'on';
%      ax.XAxis.MinorTickValues = 0:5:60;
%      ax.XAxis.TickValues = 0:10:60;
%      xlim(ax,[0 60]);    
%      set(ax,'FontSize',16,'XMinorTick','on');
hold off
ftype(1)

center=a(1)
std=a(2:3)

