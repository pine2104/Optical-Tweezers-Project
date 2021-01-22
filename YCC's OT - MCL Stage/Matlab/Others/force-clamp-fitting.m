clc
clear
close all
%constants
rbd = 520; %radius of bead(nm)
vertoffset = 200; %distance at F=0 from surface to bottom of the bead(nm)
ztrap = rbd + vertoffset; %distance from surface to trap equilibrium point(nm)
Xfc = 0.01589; %force constant in x direction(pN/nm)


name='FC_pullout';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [z xu yvf]=textread(pathname,'%f%f%f');

cr=xu(1);
 
% find voltage to nm conversion factor

[yd xv yv]=textread('x-scan-2-1.txt','%f%f%f');
% xv=data2(:,2);  %voltage of x or y x=2,y=3
yd=yd*1000;  %distance nm

%x-axis
[xvmax,Ixmax]=max(xv);
[xvmin,Ixmin]=min(xv);
xv2=xv(Ixmin:Ixmax);
yd2=yd(Ixmin:Ixmax);

 %2-1.use slope for unfolding
[ydmin3,Iymin3]=min(xv2);
[ydmax3,Iymax3]=max(xv2);
xv3=xv2((Iymin3+20):(Iymax3-20));
yd3=yd2((Iymin3+20):(Iymax3-20));
SSB=polyfit(yd3,xv3,1);
SofSB=SSB(1);
Xbd=(yvu-yr)./SofSB;


%Generate data array for unfolding
Xst=(xu-cr)*1000; % stage position
Fx=Xbd*(Xfc); % force in x direction

%Set variables for strectching fit for unfolding
kx=zeros(length(Fx),1);
kz=zeros(length(Fx),1);
for i=1:length(Fx)
    kx(i)=Fx(i)/Xbd(i);  %force constant in x-axis
    kz(i)=1/6 * kx(i);   %force constant in z-axis
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
