clc;clear;close all
load('20190708.mat')
n=length(result)
tn=[];
step=[];
for i=1:n
    t1=result{i,2};
    tn=[tn;t1(:,2)];
    step=[step;result{i,3}];
end

mean(tn)
histogram(step,9)
figure
histogram(tn,10)
