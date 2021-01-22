Fs=30; %Hz
yy=[];
for i=1:length(tn)    
  t=[0:1/Fs:tn(i)];  
  y=square(2*pi*t(1:(length(t)))/(2*tn(i)))*(-1)^(i+1);  %²£¥Ídwell time 
  yy=[yy y];
end
nn=300;
yc=autocorr(yy,nn);
tt=linspace(0,nn/Fs,nn+1);
a=log(yc);
plot(tt,a)
a=a';
tt=tt';
  
  