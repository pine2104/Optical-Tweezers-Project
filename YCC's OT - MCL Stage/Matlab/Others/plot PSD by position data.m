clc;clear;close all

%load data
name='QPD-3mW-fan on-sample,ch 7500-100s-3-1';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y]=textread(pathname,'%f%f');  
 data=y; % x or y 
 rate=15000;
 N=30000;
 for i=1:40
     z(i,:)=data(1+N*(i-1):N*i);
     Z(i,:)=abs(fft(z(i,:))).^2/(N/rate);
 end
 Zm=mean(Z);
%  Zm=fftshift(Zm); 
fs=rate/2;
freqStep=rate/N;
freq = freqStep*(0:N/2-1);	% freq resolution in spectrum (頻域的頻率的解析度)
n=length(freq);
loglog(freq,Zm(1:n))
