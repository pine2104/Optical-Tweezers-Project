%Combining Cheng-Ting's locating center point codes and Perkins' geometry
%correction codes

clc
clear
close all
%constants
rbd = 520; %radius of bead(nm)
vertoffset = 200; %distance at F=0 from surface to bottom of the bead(nm)
ztrap = rbd + vertoffset; %distance from surface to trap equilibrium point(nm)
Xvtn = 0.005500431; %voltage to nanometer constant in x direction(v/nm)
Xfc = 0.01989; %force constant in x direction(pN/nm)
ForceOffset =4 ;
DNALengthOffset =   200;
Vshift=0 ;    %initial value
save='Force-extension-unfolding-'
%Temperature = 298; %unit in K % Need to change mannually in fitting
%function.

%load data
name='x-handle-h200-3-1';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y z]=textread(pathname,'%f%f%f');
 % for 4 piese of extension 
 xmu=x(1:round(length(x)/4)); %-x direction unfolding
 xmf=x((round(length(x)/4+1):round(length(x)/2))); %-x direction folding
 xpu=x((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding
 xpf=x((round(length(x)/4*3)+1):round(length(x))); %+x direction folding
 
 yvmu=y(1:round(length(x)/4)); %-x direction unfolding voltage
 yvmf=y((round(length(x)/4+1):round(length(x)/2))); %-x direction folding voltage
 yvpu=y((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding voltage
 yvpf=y((round(length(x)/4*3)+1):length(x)); %+x direction folding voltage
  
 xu=[xmu;xpu]; %all unfolding curve
 xf=[xmf;xpf]; %all folding curve
 yvu=[yvmu;yvpu]; %all unfolding voltage
 yvf=[yvmf;yvpf]; %all folding voltage
 

 % for normal mode

% x=initialdata(:,1);
% y=initialdata(:,2);
 
% %排列位置座標
% [x Ix1]=sort(x);
%  y=y(Ix1);
% %x-axis
%  [V1 I1]=min(y);
%  [V2 I2]=max(y);
% %y-axis
% % [V1 I1]=max(y);
% % [V2 I2]=min(y);
% 
%  x=x((I1):(I2));
%  y=y((I1):(I2));

 %排列位置座標　for 四段f-e curve for UNFOLDING
[xu Ix1]=sort(xu);
 yvu=yvu(Ix1);
%x-axis
 [V1 I1]=min(yvu);
 [V2 I2]=max(yvu);
%y-axis
% [V1 I1]=max(y);
% [V2 I2]=min(y);

 xu=xu((I1):(I2));
 yvu=yvu((I1):(I2));
 x=xu;
 y=yvu;
%  %排列位置座標　for 四段f-e curve for FOLDING
% [xf Ix1]=sort(xf);
%  yvf=yvf(Ix1);
% %x-axis
%  [V1 I1]=min(yvf);
%  [V2 I2]=max(yvf);
% %y-axis
% % [V1 I1]=max(y);
% % [V2 I2]=min(y);
% 
%  xf=xf((I1):(I2));
%  yvf=yvf((I1):(I2));
%  x=xf;
%  y=yvf;

% find voltage to nm conversion factor

[yd xv yv]=textread('x-scan-2-1.txt','%f%f%f');
% xv=data2(:,2);  %voltage of x or y x=2,y=3
yd=yd*1000;  %distance nm

%x-axis
[xvmax,Ixmax]=max(xv);
[xvmin,Ixmin]=min(xv);
xv2=xv(Ixmin:Ixmax);
yd2=yd(Ixmin:Ixmax);

%y-axis
% [ydmin,Iymin]=min(xv);
% [ydmax,Iymax]=max(xv);
% xv2=xv(Iymax:Iymin);
% yd2=yd(Iymax:Iymin);

Vshift=max(y)-max(xv2) ;
xv2=xv2+Vshift ;
a=polyfit(xv2,yd2,7);



 c0=14.3;                     %guess center point
  [dev1 c0_index]=min(abs(x-c0));
  c0=x(c0_index);
  y0=y(c0_index);
  L=length(x);
  %scan range 
  %from c0_index-12 to c0_index+20
  residue=zeros(1,c0_index+10);
  for ii=c0_index-10:c0_index+10;
     %plot rotation
     y2=2*y(ii)-y;
     x2=2*x(ii)-x;   
      %tx scna length
      if L-ii+1<ii;
          %transform xy
      tx=x(ii:L);
      ty=y(ii:L);
      %transform x2y2
      tx2=x2(2*ii-L:ii);
      ty2=y2(2*ii-L:ii);
      lengthii=L-ii+1;
      else
          %transform xy
          tx=x(ii:2*ii-1);
          ty=y(ii:2*ii-1);
          %transform x2y2
          tx2=x2(1:ii);
          ty2=y2(1:ii);
          lengthii=ii;
      end
      y2r=zeros(lengthii,1);
       for kk=1:lengthii;
           y2r(kk)=ty2(lengthii-kk+1);
       end
           ty2r=y2r;         
          residue(ii)=sum(((ty2r-ty).^2)/lengthii);
  end
  residue(1:c0_index-11)=10;
  [smallest_residue cr_index]=min(residue);
  %center point
  cr=x(cr_index)+0.00001;
  yr=y(cr_index)+0.00001;

% new method to find center
% 
% cr=(x(1)+x(length(y)))/2 +0.0000001;
% yr=(min(y)+max(y))/2 +0.0000001;



%1.use power series 7th order
%convert extension (7th order)
% ydist=a(8)+a(7)*y+a(6)*y.^2+a(5)*y.^3+a(4)*y.^4+a(3)*y.^5+a(2)*y.^6+a(1)*y.^7;
% yrdist=a(8)+a(7)*yr+a(6)*yr.^2+a(5)*yr.^3+a(4)*yr.^4+a(3)*yr.^5+a(2)*yr.^6+a(1)*yr.^7;
% Xbd=(ydist-yrdist); % distance in x from trap center to bead center

 %2.use slope
[ydmin3,Iymin3]=min(xv2);
[ydmax3,Iymax3]=max(xv2);
xv3=xv2((Iymin3+20):(Iymax3-20));
yd3=yd2((Iymin3+20):(Iymax3-20));
SSB=polyfit(yd3,xv3,1);
SofSB=SSB(1);
%change y to yvu or yvf
Xbd=(y-yr)./SofSB;

% %Generate data array
% Xst=(x-cr)*1000; % stage position
% Fx=Xbd*(Xfc); % force in x direction

%Generate data array for unfolding
Xst=(x-cr)*1000; % stage position
Fx=Xbd*(Xfc); % force in x direction

% %Generate data array for folding
% Xst=(xf-cr)*1000; % stage position
% Fx=Xbd*(Xfc); % force in x direction

%Set variables for strectching fit
kx=zeros(length(Fx),1);
kz=zeros(length(Fx),1);
for i=1:length(Fx)
    kx(i)=Fx(i)/Xbd(i);  %force constant in x-axis
    kz(i)=1/6 * kx(i);   %force constant in z-axis
end

%Calculate geometry corrected xDNA, Force and zbd
zbd=zeros(length(Xst),1);
xDNA=zeros(length(Xst),1);
Force=zeros(length(Xst),1);
for ii=1:length(Xst)
%     theta(ii)=atan(ztrap/abs(Xst(ii)));
%     xDNA(ii)=(abs((Xst(ii)-Xbd(ii)))./cos(theta(ii)));
    
     zbd(ii)=(ztrap/((kz(ii)/kx(ii)*(Xst(ii)-Xbd(ii))/Xbd(ii))+1)); %相似三角形去得到bead到trap center的z差值
     %xDNA(ii)=(Xst(ii)-Xbd(ii))/ (cos(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)) ))); %use dx
     xDNA(ii)=(ztrap-zbd(ii))/ (sin(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)) ))); %use dz %calculate DNA length
    xDNAsign(ii)=abs(sign(Xst(ii))-sign(xDNA(ii)));
    if xDNAsign(ii)>0
        xDNA(ii)=-xDNA(ii); %reverse the sign of xDNA
    end
    xDNA(ii)=xDNA(ii)-sign(Xst(ii))*rbd; %substract bead radius
    
    Force(ii)=Fx(ii)/(cos(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)))));
    Forcesign(ii)=abs(sign(Fx(ii))-sign(Force(ii)));
    if Forcesign(ii)>0
        Force(ii)=-Force(ii);  %if signs of Fx and Force are different, reverse the sign of Force
    end
end



% 
% Force=-Force;
%Delete points if force is low or force is not opposing

for iii=1:length(xDNA)
    if xDNA(iii)*Force(iii)<0
        del(iii)=iii;        
    else 
        xDNA(iii)=xDNA(iii);
        Force(iii)=Force(iii);
    end
end
del=find(del~=0)
xDNA(del)=[];
Force(del)=[];

%  for iii=1:length(xDNA)
%      if (Xst(iii)-Xbd(iii)/Xbd(iii))<0
%          xDNA(iii)=[];
%         Force(iii)=[];
%         dele(iii)=iii;
%      end
%      if abs(xDNA(iii))<1.2*rbd
%          xDNA(iii)=[];
%          Force(iii)=[];
%          del(iii)=iii;
%      end
%  end

%Delete points does not follow: positive extension while positive force
% 
%   odd=zeros(length(xDNA),1);
%   c=0;
%   
%   for iiii=1:length(xDNA)
%       a=sign(Force(iiii));
%       b=sign(xDNA(iiii));
%       if a~=b
%          if abs(Force(iiii)) >= 0.5
%              c=c+1;
%              odd(c)=iiii;
%          end
%       else
%           if abs(xDNA(iiii)) <= 1000
%               if abs(Force(iiii)) >= 0.5
%                   c=c+1;
%                   odd(c)=iiii;
%               end
%           end
%       end
%   end
%   
%   odd=odd(1:c);
%   
%   Force(odd)=[];
%   xDNA(odd)=[];
% 
% % Remove noisy parts

     Force(xDNA>0&xDNA<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     Force(xDNA<0&xDNA>-DNALengthOffset)=[]; %&xDNA>-DNALengthOffset
     xDNA(xDNA>0&xDNA<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     xDNA(xDNA<0&xDNA>-DNALengthOffset)=[];%&xDNA>-DNALengthOffset
      xDNA(Force> ForceOffset)=[];
      xDNA(Force<-ForceOffset)=[];
      Force(Force> ForceOffset)=[];
      Force(Force<-ForceOffset)=[];
            
% %       Force(xDNA<0)=[];
% %       xDNA(xDNA<0)=[];
%   xDNA(Force<0)=[];   
%   Force(Force<0)=[];
%   Force(Force>0&xDNA<0)=[];
%   Force(Force<0&xDNA<0)=[];
%   xDNA(Force>0&xDNA<0)=[];
%   xDNA(Force<0&xDNA>0)=[];

xlswrite([save name],[xDNA Force]);    
s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...          %
               'Upper',[3000,2],...      %
               'Startpoint',[1200,0.80]);   %L0 % P guess value
fec=fittype('0.0408687*(n/P)*(sign(u)*1/4*(1-sign(u)*u/L0)^(-2)-(1/4*sign(u))+u/L0+(-0.5164228)*((u/L0)^(2))*sign(u)+(-2.737418)*((u/L0)^(3))+(16.07497)*((u/L0)^(4))*sign(u)+(-38.87607)*((u/L0)^(5))+(39.49944)*((u/L0)^(6))*sign(u)+(-14.17718)*((u/L0)^(7)))','problem','n','independent','u',...
    'options',s);
[c2, gof2]=fit(xDNA,Force,fec,'problem',1);
xmin=min(xDNA);
ymin=min(Force);
xend=max(xDNA);
ymax=max(Force);
ylimithigh=ceil(ymax);
yendhigh=ylimithigh;
ylimitlow=floor(ymin);
yendlow=ylimitlow;
plot(xDNA,Force,'o');
axis([xmin-100 xend+100 yendlow yendhigh]);
hold on
plot(c2);
% Create xlabel
xlabel('extension (nm)');

% Create ylabel
ylabel('force (pN)');
%hold off

c2

