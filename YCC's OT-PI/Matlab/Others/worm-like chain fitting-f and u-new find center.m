%Combining Cheng-Ting's locating center point codes and Perkins' geometry
%correction codes

clc
clear
close all
%constants
rbd = 520; %radius of bead(nm)
vertoffset = 300; %distance at F=0 from surface to bottom of the bead (nm)
ztrap = rbd + vertoffset; %distance from surface to trap equilibrium point (nm)
Xvtn = 0.02000431; %voltage to nanometer constant in x direction (v/nm)
Xfc = 0.0455; %force constant in x direction (pN/nm)
ForceOffset =5;
DNALengthOffset =600;
crshift=-0.2892519505101005016409500;
Vshift=+0.00100320510016178 ;    %initial value
ci=10.3509940687821614;
save='Force-extension-f+u-'
% savef='Force-extension-folding-'
%Temperature = 298; %unit in K % Need to change mannually in fitting
%function.

%load data
name='TNR21-y-f+u-10mW-c10-7586-h300-s5p1000-1-13';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y z q]=textread(pathname,'%f%f%f%f');
 % for 4 piese of extension 
 xmu=x(1:round(length(x)/4)); %-x direction unfolding
 xmf=x((round(length(x)/4+1):round(length(x)/2))); %-x direction folding
 xpu=x((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding
 xpf=x((round(length(x)/4*3)+1):round(length(x))); %+x direction folding
 
%  yvmu=y(1:round(length(x)/4)); %-x direction unfolding voltage
%  yvmf=y((round(length(x)/4+1):round(length(x)/2))); %-x direction folding voltage
%  yvpu=y((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding voltage
%  yvpf=y((round(length(x)/4*3)+1):length(x)); %+x direction folding voltage
 
 yvmu=z(1:round(length(x)/4)); %-y direction unfolding voltage
 yvmf=z((round(length(x)/4+1):round(length(x)/2))); %-y direction folding voltage
 yvpu=z((round(length(x)/2)+1):round(length(x)/4*3)); % +y direction unfolding voltage
 yvpf=z((round(length(x)/4*3)+1):length(x)); %+y direction folding voltage
 
 xu=[xmu;xpu]; %all unfolding position curve
 xf=[xmf;xpf]; %all folding position curve
 yvu=[yvmu;yvpu]; %all unfolding QPD voltage
 yvf=[yvmf;yvpf]; %all folding QPD voltage
 
 %排列位置座標　for 四段f-e curve for UNFOLDING
[xu Ix1]=sort(xu);
 yvu=yvu(Ix1);
%x-axis
 [V1 I1]=min(yvu);
 [V2 I2]=max(yvu);
%y-axis
% [V1 I1]=max(y);
% [V2 I2]=min(y);
 cru=xu(round((I1+I2)/2));
 yru=yvu(round((I1+I2)/2));
 
 xu=xu((I2):(I1));
 yvu=yvu((I2):(I1));


 %排列位置座標　for 四段f-e curve for FOLDING
[xf Ix1]=sort(xf);
 yvf=yvf(Ix1);
%x-axis
 [V1 I1]=min(yvf);
 [V2 I2]=max(yvf);
%y-axis
% [V1 I1]=max(y);
% [V2 I2]=min(y);
 crf=xf(round((I1+I2)/2));
 yrf=yvf(round((I1+I2)/2));

 xf=xf((I2):(I1));
 yvf=yvf((I2):(I1));
 

% find voltage to nm conversion factor

[yd xv yv zv]=textread('y-scan-1-1.txt','%f%f%f%f');
% xv=data2(:,2);  %voltage of x or y x=2,y=3
yd=yd*1000;  %distance nm

% %x-axis
% [xvmax,Ixmax]=max(xv);
% [xvmin,Ixmin]=min(xv);
% xv2=xv(Ixmin:Ixmax);
% yd2=yd(Ixmin:Ixmax);

%y-axis
[ydmin,Iymin]=min(yv);
[ydmax,Iymax]=max(yv);
yv2=yv(Iymax:Iymin);
yd2=yd(Iymax:Iymin);

% Vshift=max(y)-max(xv2) ;
% xv2=xv2+Vshift ;
% a=polyfit(xv2,yd2,7);

% find center point
cr=(cru+crf)/2;
yr=(yru+yrf)/2;
%  c0=ci;                     %guess center point
%   [dev1 c0_index]=min(abs(xu-c0));
%   c0=xu(c0_index);
%   y0=yvu(c0_index);
%   L=length(xu);
%   %scan range 
%   %from c0_index-12 to c0_index+20
%   residue=zeros(1,c0_index+10);
%   for ii=c0_index-10:c0_index+10;
%      %plot rotation
%      y2=2*yvu(ii)-yvu;
%      x2=2*xu(ii)-xu;   
%       %tx scna length
%       if L-ii+1<ii;
%           %transform xy
%       tx=xu(ii:L);
%       ty=yvu(ii:L);
%       %transform x2y2
%       tx2=x2(2*ii-L:ii);
%       ty2=y2(2*ii-L:ii);
%       lengthii=L-ii+1;
%       else
%           %transform xy
%           tx=xu(ii:2*ii-1);
%           ty=yvu(ii:2*ii-1);
%           %transform x2y2
%           tx2=x2(1:ii);
%           ty2=y2(1:ii);
%           lengthii=ii;
%       end
%       y2r=zeros(lengthii,1);
%        for kk=1:lengthii;
%            y2r(kk)=ty2(lengthii-kk+1);
%        end
%            ty2r=y2r;         
%           residue(ii)=sum(((ty2r-ty).^2)/lengthii);
%   end
%   residue(1:c0_index-11)=10;
%   [smallest_residue cr_index]=min(residue);
  %center point
  cr=cr+crshift;
  yr=yr+Vshift;


%1.use power series 7th order
%convert extension (7th order)
% ydist=a(8)+a(7)*y+a(6)*y.^2+a(5)*y.^3+a(4)*y.^4+a(3)*y.^5+a(2)*y.^6+a(1)*y.^7;
% yrdist=a(8)+a(7)*yr+a(6)*yr.^2+a(5)*yr.^3+a(4)*yr.^4+a(3)*yr.^5+a(2)*yr.^6+a(1)*yr.^7;
% Xbd=(ydist-yrdist); % distance in x from trap center to bead center


%  %2-1-x.use slope for unfolding
% [ydmin3,Iymin3]=min(xv2);
% [ydmax3,Iymax3]=max(xv2);
% xv3=xv2((Iymin3+10):(Iymax3-10));
% yd3=yd2((Iymin3+10):(Iymax3-10));
% SSB=polyfit(yd3,xv3,1);
% SofSB=SSB(1);
% Xbd=(yvu-yr)./SofSB;
% 
% %2-2-x.use slope for folding
% Xbdf=(yvf-yr)./SofSB;


 %2-1-y.use slope for unfolding
[ydmin3,Iymin3]=min(yv2);
[ydmax3,Iymax3]=max(yv2);
yv3=yv2((Iymax3+10):(Iymin3-10));
yd3=yd2((Iymax3+10):(Iymin3-10));
SSB=polyfit(yd3,yv3,1);
SofSB=SSB(1);
Xbd=(yvu-yr)./SofSB;

%2-2-y.use slope for folding
Xbdf=(yvf-yr)./SofSB;

% %Generate data array
% Xst=(x-cr)*1000; % stage position
% Fx=Xbd*(Xfc); % force in x direction

%Generate data array for unfolding
Xst=(xu-cr)*1000; % stage position
Fx=Xbd*(Xfc); % force in x direction

%Generate data array for folding
Xstf=(xf-cr)*1000; % stage position
Fxf=Xbdf*(Xfc); % force in x direction

%Set variables for strectching fit for unfolding
kx=zeros(length(Fx),1);
kz=zeros(length(Fx),1);
for i=1:length(Fx)
    kx(i)=Fx(i)/Xbd(i);  %force constant in x-axis
    kz(i)=1/6 * kx(i);   %force constant in z-axis
end

%Set variables for strectching fit for folding
kxf=zeros(length(Fxf),1);
kzf=zeros(length(Fxf),1);
for i=1:length(Fxf)
    kxf(i)=Fxf(i)/Xbdf(i);  %force constant in x-axis
    kzf(i)=1/6 * kxf(i);   %force constant in z-axis
end

%Calculate geometry corrected xDNA, Force and zbd for unfolding
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


%Calculate geometry corrected xDNA, Force and zbd for folding
zbdf=zeros(length(Xstf),1);
xDNAf=zeros(length(Xstf),1);
Forcef=zeros(length(Xstf),1);
for ii=1:length(Xstf)
%     theta(ii)=atan(ztrap/abs(Xst(ii)));
%     xDNA(ii)=(abs((Xst(ii)-Xbd(ii)))./cos(theta(ii)));
    
     zbdf(ii)=(ztrap/((kzf(ii)/kxf(ii)*(Xstf(ii)-Xbdf(ii))/Xbdf(ii))+1)); %相似三角形去得到bead到trap center的z差值
     %xDNA(ii)=(Xst(ii)-Xbd(ii))/ (cos(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)) ))); %use dx
     xDNAf(ii)=(ztrap-zbdf(ii))/ (sin(atan((ztrap-zbdf(ii))/(Xstf(ii)-Xbdf(ii)) ))); %use dz %calculate DNA length
    xDNAsignf(ii)=abs(sign(Xstf(ii))-sign(xDNAf(ii)));
    if xDNAsignf(ii)>0
        xDNAf(ii)=-xDNAf(ii); %reverse the sign of xDNA
    end
    xDNAf(ii)=xDNAf(ii)-sign(Xstf(ii))*rbd; %substract bead radius
    
    Forcef(ii)=Fxf(ii)/(cos(atan((ztrap-zbdf(ii))/(Xstf(ii)-Xbdf(ii)))));
    Forcesignf(ii)=abs(sign(Fxf(ii))-sign(Forcef(ii)));
    if Forcesignf(ii)>0
        Forcef(ii)=-Forcef(ii);  %if signs of Fx and Force are different, reverse the sign of Force
    end
end

% 
% Force=-Force;
%Delete points if force is low or force is not opposing for unfolding

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

%Delete points if force is low or force is not opposing for unfolding

for iii=1:length(xDNAf)
    if xDNAf(iii)*Forcef(iii)<0
        delf(iii)=iii;        
    else 
        xDNAf(iii)=xDNAf(iii);
        Forcef(iii)=Forcef(iii);
    end
end
delf=find(delf~=0)
xDNAf(delf)=[];
Forcef(delf)=[];


% % Remove noisy parts for unfolding

     Force(xDNA>0&xDNA<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     Force(xDNA<0&xDNA>-DNALengthOffset)=[]; %&xDNA>-DNALengthOffset
     xDNA(xDNA>0&xDNA<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     xDNA(xDNA<0&xDNA>-DNALengthOffset)=[];%&xDNA>-DNALengthOffset
      xDNA(Force> ForceOffset)=[];
      xDNA(Force<-ForceOffset)=[];
      Force(Force> ForceOffset)=[];
      Force(Force<-ForceOffset)=[];
% % Remove noisy parts for folding

     Forcef(xDNAf>0&xDNAf<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     Forcef(xDNAf<0&xDNAf>-DNALengthOffset)=[]; %&xDNA>-DNALengthOffset
     xDNAf(xDNAf>0&xDNAf<DNALengthOffset)=[];  %&xDNA<DNALengthOffset
     xDNAf(xDNAf<0&xDNAf>-DNALengthOffset)=[];%&xDNA>-DNALengthOffset
      xDNAf(Forcef> ForceOffset)=[];
      xDNAf(Forcef<-ForceOffset)=[];
      Forcef(Forcef> ForceOffset)=[];
      Forcef(Forcef<-ForceOffset)=[];      
            
% %       Force(xDNA<0)=[];
% %       xDNA(xDNA<0)=[];
%   xDNA(Force<0)=[];   
%   Force(Force<0)=[];
%   Force(Force>0&xDNA<0)=[];
%   Force(Force<0&xDNA<0)=[];
%   xDNA(Force>0&xDNA<0)=[];
%   xDNA(Force<0&xDNA>0)=[];

%save data


% % 
% xlswrite([save name],[xDNA Force],'unfolding');  
% xlswrite([save name],[xDNAf Forcef], 'folding'); 

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
title('unfolding')
axis([xmin-100 xend+100 yendlow yendhigh]);
hold on
plot(c2);
% Create xlabel
xlabel('extension (nm)');

% Create ylabel
ylabel('force (pN)');
%hold off

c2


s = fitoptions('Method','NonlinearLeastSquares',...
               'Lower',[0,0],...          %
               'Upper',[3000,2],...      %
               'Startpoint',[1200,0.80]);   %L0 % P guess value
fec=fittype('0.0408687*(n/P)*(sign(u)*1/4*(1-sign(u)*u/L0)^(-2)-(1/4*sign(u))+u/L0+(-0.5164228)*((u/L0)^(2))*sign(u)+(-2.737418)*((u/L0)^(3))+(16.07497)*((u/L0)^(4))*sign(u)+(-38.87607)*((u/L0)^(5))+(39.49944)*((u/L0)^(6))*sign(u)+(-14.17718)*((u/L0)^(7)))','problem','n','independent','u',...
    'options',s);
[cf, gof2]=fit(xDNAf,Forcef,fec,'problem',1);
xmin=min(xDNAf);
ymin=min(Forcef);
xend=max(xDNAf);
ymax=max(Forcef);
ylimithigh=ceil(ymax);
yendhigh=ylimithigh;
ylimitlow=floor(ymin);
yendlow=ylimitlow;
figure
plot(xDNAf,Forcef,'o');
title('folding')
axis([xmin-100 xend+100 yendlow yendhigh]);
hold on
plot(cf);
% Create xlabel
xlabel('extension (nm)');

% Create ylabel
ylabel('force (pN)');
%hold off

cf

