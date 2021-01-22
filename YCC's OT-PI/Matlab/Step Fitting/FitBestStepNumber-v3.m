clear;clc;close all
filename='AllData'
file=[filename '.xlsx']
y=xlsread(file);
nt=size(y);
nt=nt(2)/4; %number of traces

sm=20; %max number of step to try to fit

for k=1:nt
    x=y(2:end,2+4*(k-1));
    x(isnan(x))=[];
    xi=y(2:end,4+4*(k-1)); %raw dat no filter
    xi(isnan(xi))=[];
%     x(x==0)=[];
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
%               if all(Stepsize(:,s)==Stepsize(:,s-1))
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
    dt=(y(3,1+4*(k-1))-y(1,1+4*(k-1)))/2;
    result{k,1}=[xi,x,xm(:,s-1)];
    result{k,2}=[mi,taui*dt];
    result{k,3}=Stepsizei;
    result{k,4}=dt;  %dt

    
end


step=[];
tn=[];
for ii=1:k
    figure(ii);
    data=result{ii,1};
    t=[1:length(data)]*result{1,4};
    plot(t,data(:,1),'Color',[0.5 0.5 0.5]);
    hold on
    plot(t,data(:,2),'k');   %
    plot(t,data(:,3),'r','Linewidth',1);
    hold off
    xlabel('Time (s)');
    ylabel('mRad51 count (numbers)');
    set(gca,'FontName','Arial','FontSize',12)
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

save 20190708 result