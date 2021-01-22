function [center std all]=figplot(x1,y1,x2,y2,cguess)

y=@(x,xm,sd,A) A*exp(-(x-xm).^2/2/sd^2);


SS1=@(p) sum(((y1-y(x1,p(1),p(2),p(3))).^2));
SS2=@(p) sum(((y2-y(x2,p(1),p(2),p(3))).^2));


SSS=@(p) SS1([p(1),p(2),p(3)])+SS2([p(1),p(4),p(5)]);


 a=fminsearch(SS1,[35,2.9,0.3,2.5,0.3]);


  
 xA=[a(1)-5*a(2):0.1:a(1)+5*a(2)];
 xB=[a(1)-5*a(4):0.1:a(1)+5*a(4)];
 y1best=y(xA,a(1),a(2),a(3));
 y2best=y(xB,a(1),a(4),a(5));
 
  figure
bar(x1,y1,'LineWidth',1.5,...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'BarWidth',1);
hold on
plot(xA,y1best,'r')
hold off
ftype(1)

figure
bar(x2,y2,'LineWidth',1.5,...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'BarWidth',1);
hold on
plot(xB,y2best,'r')
hold off
ftype(1)


center=a(1);
std=a([2 4]);
all=a;

