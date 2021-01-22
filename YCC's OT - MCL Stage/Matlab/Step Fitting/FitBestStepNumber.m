clear;clc;close all
filename='AllData'
file=[filename '.xlsx']
y=xlsread(file);
nt=size(y);
nt=nt(2);


sm=20; %max number of step to try to fit

for k=1:nt
    x=y(:,k);
    x(isnan(x))=[];
    x(x==0)=[];
%     x=x-70;
    xm=[];
    m=[];
    Stepsize=[];
    tau=[];
    for s=1:sm    
        [ipt,residual]=findchangepts(x,'Statistic','mean','MaxNumChanges',s);
        ipt2=[];
        ipt2=[0;ipt;length(x)];

        for i=1:length(ipt2)-1
            tau(i,s)=ipt2(i+1)-ipt2(i)+1;
            m(i,s)=mean(x(ipt2(i)+1:ipt2(i+1)));
            xm(ipt2(i)+1:ipt2(i+1),s)=m(i,s);
        end

        for j=1:length(m)-1
            Stepsize(j,s)=m(j+1,s)-m(j,s);
        end


        if s>=2
            if all(Stepsize(:,s)==Stepsize(:,s-1))|sum(Stepsize(1:s,s)<0)>=1
    %       if any(Stepsize(:,s)<0) 
                break
            end
        end

    end
%     figure(k)
%     plot(x,xm(:,s-1))
    taui=tau(:,s-1);
    Stepsizei=Stepsize(:,s-1);
    mi=m(:,s-1);
    taui(taui==0)=[];
    mi(mi==0)=[];
    Stepsizei(Stepsizei>20|Stepsizei==0)=[];

    result{k,1}=[x,xm(:,s-1)];
    result{k,2}=[mi,taui];
    result{k,3}=Stepsizei;

    
end


step=[];
tn=[];
for ii=1:k
    figure(ii);
    plot(result{ii,1});
    xlabel('Time (point)');
    ylabel('mRad51 count (number)');
    saveas(gcf,[num2str(ii) '.jpg']);
    step=[step;result{ii,3}];
    tn=[tn;result{ii,2}(:,2)];
end

hn=8;
% tn(step>20|tn==0)=[];
% step(step>20|step==0)=[];
stepm=mean(step)
% hist(step,hn);
[n c]=hist(step,hn);

save 20190616-all