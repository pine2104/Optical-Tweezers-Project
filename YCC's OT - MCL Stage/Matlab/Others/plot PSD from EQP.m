clc;clear;close all
%load data
name='EQP-2mW-4';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x y]=textread(pathname,'%f%f');  

N=length(y);
fs=15000;
freqStep=fs/N;
freq = freqStep*(-N/2:N/2-1);	% freq resolution in spectrum (頻域的頻率的解析度)
yft=fft(y);
yft=fftshift(yft);
yftamp=abs(yft);
PSD=yftamp.^2/(N/fs);
loglog(freq,PSD)