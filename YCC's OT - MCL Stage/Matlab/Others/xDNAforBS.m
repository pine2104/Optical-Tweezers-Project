saveubs='Bead uncertainty-'
name='x-BS-hairpin-h200-s10f750-1-2';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y]=textread(pathname,'%f%f');
 % for 4 piese of extension 
 xmubs=x(1:round(length(x)/4)); %-x direction unfolding
 xmfbs=x((round(length(x)/4+1):round(length(x)/2))); %-x direction folding
 xpubs=x((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding
 xpfbs=x((round(length(x)/4*3)+1):round(length(x))); %+x direction folding
 
 
 yvmubs=y(1:round(length(x)/4)); %-x direction unfolding voltage
 yvmfbs=y((round(length(x)/4+1):round(length(x)/2))); %-x direction folding voltage
 yvpubs=y((round(length(x)/2)+1):round(length(x)/4*3)); % +x direction unfolding voltage
 yvpfbs=y((round(length(x)/4*3)+1):length(x)); %+x direction folding voltage
 
 xubs=[xmubs;xpubs]; %all unfolding curve
 xfbs=[xmfbs;xpfbs]; %all folding curve
 yvubs=[yvmubs;yvpubs]; %all unfolding voltage
 yvfbs=[yvmfbs;yvpfbs]; %all folding voltage
 
 [xubs Ix1bs]=sort(xubs);
 yvubs=yvubs(Ix1bs);
 
 [xfbs Ix2bs]=sort(xfbs);
 yvfbs=yvfbs(Ix2bs);
 
 
  xubs=xubs((I1):(I2));
  xfbs=xfbs((I1):(I2));
  yvubs=yvubs((I1):(I2));
  yvfbs=yvfbs((I1):(I2));

  
  %Generate data array for unfolding
Xstbs=(xubs-cr)*1000; % stage position

%Generate data array for folding
Xstfbs=(xfbs-cr)*1000; % stage position


%Calculate geometry corrected xDNA, Force and zbd for unfolding
zbdbs=zeros(length(Xstbs),1);
xDNAbs=zeros(length(Xstbs),1);
for ii=1:length(Xst)
   
     zbdbs(ii)=(ztrap/((kz(ii)/kx(ii)*(Xstbs(ii)-Xbd(ii))/Xbd(ii))+1)); %相似三角形去得到bead到trap center的z差值
     xDNAbs(ii)=(ztrap-zbdbs(ii))/ (sin(atan((ztrap-zbdbs(ii))/(Xstbs(ii)-Xbd(ii)) ))); %use dz %calculate DNA length
    xDNAsignbs(ii)=abs(sign(Xstbs(ii))-sign(xDNAbs(ii)));
    if xDNAsignbs(ii)>0
        xDNAbs(ii)=-xDNAbs(ii); %reverse the sign of xDNA
    end
    xDNAbs(ii)=xDNAbs(ii)-sign(Xstbs(ii))*rbd; %substract bead radius    
   
end


%Calculate geometry corrected xDNA, Force and zbd for folding
zbdfbs=zeros(length(Xstfbs),1);
xDNAfbs=zeros(length(Xstfbs),1);
for ii=1:length(Xstfbs)
    
     zbdfbs(ii)=(ztrap/((kzf(ii)/kxf(ii)*(Xstfbs(ii)-Xbdf(ii))/Xbdf(ii))+1)); %相似三角形去得到bead到trap center的z差值
     xDNAfbs(ii)=(ztrap-zbdfbs(ii))/ (sin(atan((ztrap-zbdfbs(ii))/(Xstfbs(ii)-Xbdf(ii)) ))); %use dz %calculate DNA length
    xDNAsignfbs(ii)=abs(sign(Xstfbs(ii))-sign(xDNAfbs(ii)));
    if xDNAsignfbs(ii)>0
        xDNAfbs(ii)=-xDNAfbs(ii); %reverse the sign of xDNA
    end
    xDNAfbs(ii)=xDNAfbs(ii)-sign(Xstfbs(ii))*rbd; %substract bead radius   
   
end

xDNAbs(del)=[];
xDNAfbs(delf)=[];
yvubs(del)=[];


figure
 plot(xDNAbs,yvubs)
 xlswrite([saveubs name],[xDNAbs yvubs]);  