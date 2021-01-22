[a c]=hist(y,100);
P=a/sum(a);
G=-log(P);
%      f(x) =  a1*exp(-((x-b1)/c1)^2) + a2*exp(-((x-b2)/c2)^2)
% Coefficients (with 95% confidence bounds):
%        a1 =   9.581e+04  (9.462e+04, 9.699e+04)
%        b1 =       553.7  (553.7, 553.7)
%        c1 =       3.826  (3.772, 3.881)
%        a2 =   5.001e+04  (4.899e+04, 5.102e+04)
%        b2 =       527.3  (527.2, 527.4)
%        c2 =       5.209  (5.087, 5.331)
x=linspace(-20,50,20);
% x2=linspace(-5,31,180);
s=20;
% s1=1;
% s2=1.1;
psf=1./(s*sqrt(2*pi)).*exp((-x.^2)./(2.*s^2));
% po=1./(s1*sqrt(2*pi)).*exp((-x2.^2)./(2.*s1^2))+1./(s2.*sqrt(2.*pi)).*exp((-(x2-26).^2)/(2.*s2^2))
%  plot(x2,p,'o')
n=length(psf);
m=length(P);
p=[];
p(:,1)=P;
r0=2;
for i=2:50
    
    Pc=conv(psf,p(:,i-1)); %length=n+m-1
    p(:,i)=zeros(m,1);
    
   
    for ii=1:m        
        r=r0*(1-2*abs(p(ii,i-1)-0.5))
        p(ii,i)=p(ii,i-1)+r*(P(ii)-Pc(n/2+ii-1));
  
      
    end
    R=-Pc(n/2:(n/2+m-1))+p(:,i);
    plot(p(:,i))
%     hold on
%     plot(R,'-r')
%     hold off
pause(0.1)
end
% plot(p1(100,:))

% figure
% plot(P)
% figure
%  plot(p(:,200))

