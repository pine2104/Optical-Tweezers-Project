% clc;clear;close all

% input data: "tn" and press Run Section

nboot=5000; % # of bootstrap
n=200; %try k interative #
for ii=1:nboot
    r=ceil(length(tn)*rand(1,length(tn))); % creat random array (抽球)
    tboot=tn(r);  % 得到新抽出來的data set
    gtau=mean(tboot); % initial guess of tau
    kexp=1/gtau; % initial guess of k
     for i=1:n %try n次
        
       tau(i)=gtau-10+20*i/n; % try range from gtau-10 to gtau+10
        k(i)=1/tau(i); % try k
        p2=log(k(i)*exp(-k(i)*tboot)); % 在time=tn時, 成功之機率
        ML(i)=-sum(p2); % ML function
    end
  [Y I]=min(ML); % find min
kML(ii)=k(I);    % find the k let ML reach min 
end

hist(kML) % plot the k hist




