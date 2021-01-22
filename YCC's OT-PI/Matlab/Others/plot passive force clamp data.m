clc;clear;close all
%load data
name='FC-data';
%pathname=[name '.xlsx'];
 pathname=[name '.txt'];
%initialdata=xlsread(pathname);
 [x z y a b]=textread(pathname,'%f%f%f%f%f');
 plot(b)
 axis([200000 400000 1 0.8])