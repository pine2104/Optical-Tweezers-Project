clc;clear;close all
%constants
rbd = 515; %radius of bead(nm)
vertoffset = 400; %distance at F=0 from surface to bottom of the bead(nm)
ztrap = rbd + vertoffset; %distance from surface to trap equilibrium point(nm)
laserpower=15;
% Xfc = 0.030301203889; %force constant in x direction(pN/nm)
ForceOffset =5;
DNALengthOffset =  1000;
cr=11.2263;
yr=0.0459;
%Temperature = 298; %unit in K % Need to change mannually in fitting
%function.
%load data
name='x-15mW-PassiveFC-1-8';


 pathname=[name '.txt'];

Vx=[];
 [Vx tt]=textread(pathname,'%f%f');  %x: stage position, y: x-QPD, z:y-QPD


y=Vx(380000 :480000);
t=[1:length(y)]'/20000;
x=[];
x=ones(length(y),1)*9.35;

% find voltage to nm conversion factor
% SSB=0.199648*laserpower-0.002291;
SSB=1.45
SofSB=SSB;
Xbd=540-1000*(y-0.45)/SofSB;


%Generate data array
Xfc=0.0049150*laserpower-0.00492407;
% Xfc=0;
Xst=-(x-cr)*1000; % stage position
% Fx=Xbd*(Xfc); % force in x direction

%Set variables for strectching fit
% kx=zeros(length(Fx),1);
% kz=zeros(length(Fx),1);
% for i=1:length(Fx)
%     kx(i)=Fx(i)/Xbd(i);  %force constant in x-axis
%     kz(i)=1/6 * kx(i);   %force constant in z-axis
% end

%Calculate geometry corrected xDNA, Force and zbd
zbd=zeros(length(Xst),1);
xDNA=zeros(length(Xst),1);
% Force=zeros(length(Xst),1);
zbd=ones(length(Xst),1)*150;
for ii=1:length(Xst)
%   zbd(ii)=(ztrap/((kz(ii)/kx(ii)*(Xst(ii)-Xbd(ii))/Xbd(ii))+1)); %相似三角形去得到bead到trap center的z差值
%   xDNA(ii)=(Xst(ii)-Xbd(ii))/ (cos(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)) ))); %use dx
    xDNA(ii)=(ztrap-zbd(ii))/ (sin(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)) ))); %use dz %calculate DNA length
    xDNAsign(ii)=abs(sign(Xst(ii))-sign(xDNA(ii)));
    if xDNAsign(ii)>0
        xDNA(ii)=-xDNA(ii); %reverse the sign of xDNA
    end
    xDNA(ii)=xDNA(ii)-sign(Xst(ii))*(rbd); %substract bead radius
    
%     Force(ii)=Fx(ii)/(cos(atan((ztrap-zbd(ii))/(Xst(ii)-Xbd(ii)))));
%     Forcesign(ii)=abs(sign(Fx(ii))-sign(Force(ii)));
%     if Forcesign(ii)>0
%         Force(ii)=-Force(ii);  %if signs of Fx and Force are different, reverse the sign of Force
%     end
end


xDNAf=sgolayfilt(xDNA,3,501);
plot(t,xDNA)
hold on
plot(t,xDNAf)
hold off  

