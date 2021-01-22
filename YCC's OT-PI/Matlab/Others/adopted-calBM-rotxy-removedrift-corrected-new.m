clc;clear;close all
    %input file_name 
    name='20190119lane1-before adding';
    pathname=[name '.csv'];
    initialdata=xlsread(pathname);
    %input number of aoi

    %input window size
    BMuplimit=1.38; % pixel 超過此值歸零
    
    window_size=60;
    bead=initialdata(:,2);
    xii=initialdata(:,9);
    yii=initialdata(:,10);
    number_of_beads=max(bead);

    %input # of frame per bead
    nf=length(xii)/number_of_beads;
    
    
% 使用stuck-bead則開起此區
%     %input stuck-bead data
%     namesb='su';
%     pathnamesb=[namesb '.csv'];
%     initialdatasb=xlsread(pathnamesb);
%     xisb=initialdatasb(:,9);
%     yisb=initialdatasb(:,10);

% % 若不用stuck-bead則使用下方
%     xisb=zeros(length(xii),1);  
%     yisb=zeros(length(yii),1);


    
for j=1:6
    if j==1
        %input file_name       

        x=xii;
        y=yii;
        
%         % stuck-bead
%         Zsb=rotz(15*(j-1))*[xisb yisb zeros(length(xii),1)]';
%         xsb=(Zsb(1,:))';
%         ysb=(Zsb(2,:))';    
        
        number_of_frames=length(x)/number_of_beads;
        organizedx=(reshape(x,number_of_beads,number_of_frames));
        organizedy=(reshape(y,number_of_beads,number_of_frames));
%         oxsb=(reshape(xsb,number_of_beads,number_of_frames))';
%         oysb=(reshape(ysb,number_of_beads,number_of_frames))';
                       
        
        organizedx(find(organizedx<=0))=nan; %將glimpse的fitting error變成nan
        organizedy(find(organizedy<=0))=nan; %將glimpse的fitting error變成nan       
%         %用stuck-bead position扣除drift
%         organizedx=organizedx-oxsb;
%         organizedy=organizedy-oysb;        

        
        % calcultae BM for fixed window
        for jjj=1:number_of_beads     %共有number_of_beads顆球
            for iii=1:floor(nf/window_size)-1  %fixed average後,變為nf/window_size個點
                stdfx(iii,jjj)=nanstd(organizedx((1+(iii-1)*window_size):(1+iii*window_size),jjj)); %每取window_size個位置座標成為一個布朗運動值(std)
                stdfy(iii,jjj)=nanstd(organizedy((1+(iii-1)*window_size):(1+iii*window_size),jjj)); %每取window_size個位置座標成為一個布朗運動值(std)
            end            
        end

        % calcultae BM for sliding window 
        for jjjj=1:number_of_beads     %共有number_of_beads顆球
            for iiii=1:nf-window_size+1 % sliding average後,變為nf-window_size+1個點
                stdsx(iiii,jjjj)=nanstd(organizedx(iiii:(iiii+window_size-1),jjjj)); %每取window_size個位置座標成為一個布朗運動值(std)
                stdsy(iiii,jjjj)=nanstd(organizedy(iiii:(iiii+window_size-1),jjjj)); %每取window_size個位置座標成為一個布朗運動值(std)
            end
        end
        
        % calculate BM of all frames for each beads
        stdax=nanstd(organizedx);
        stday=nanstd(organizedy);                 
        
% write stdx and stdy for fixed window 
        filename=[name '.xls'];
        stdfx(find(isnan(stdfx)))=0;
        stdfy(find(isnan(stdfy)))=0;
        stdfx(stdfx >= BMuplimit)=0;
        stdfy(stdfy >= BMuplimit)=0;
        xlswrite(filename,[stdfx zeros(size(stdfx,1),1) stdfy],'BMx,y fixed window');
    
% write stdx and stdy for sliding window 
        stdsx(find(isnan(stdsx)))=0;
        stdsy(find(isnan(stdsy)))=0;
        stdsx(stdsx >= BMuplimit)=0;
        stdsy(stdsy >= BMuplimit)=0;
        xlswrite(filename,[stdsx zeros(size(stdsx,1),1) stdsy],'BMx,y sliding window');

% write BMx and BMy for all frames
        BMxy=[stdax; zeros(1,size(stdax,2)); stday];
        xlswrite(filename,BMxy,'BMx,y all frames');

% write x and y positions for all frames    

        

% calculate xy ratio and write xy ratio and BM of all frames (x_y_ratio & stdax,stday)
        result=zeros(6,number_of_beads);     %存6個角度               
        result(j,:)=stdax./stday;               %存第一個角度(不轉)
      
         
         
         
        
    else   %開始算其他角度,只存x/y ratio即可
        
        %input file_name   
        Z=rotz(15*(j-1))*[xii yii zeros(size(xii,1),1)]';
        x=(Z(1,:))';
        y=(Z(2,:))';
        
%         % stuck-bead
%         Zsb=rotz(15*(j-1))*[xisb yisb zeros(size(xii,1),1)]';
%         xsb=(Zsb(1,:))';
%         ysb=(Zsb(2,:))';    
        
        number_of_frames=length(x)/number_of_beads;
        organizedx=(reshape(x,number_of_beads,number_of_frames))';
        organizedy=(reshape(y,number_of_beads,number_of_frames))';
%         oxsb=(reshape(xsb,number_of_beads,number_of_frames))';
%         oysb=(reshape(ysb,number_of_beads,number_of_frames))';
        
        organizedx(find(organizedx<=0))=nan; %將glimpse的fitting error變成nan
        organizedy(find(organizedy<=0))=nan; %將glimpse的fitting error變成nan 
      
%         %用stuck-bead position扣除drift
%         organizedx=organizedx-oxsb;
%         organizedy=organizedy-oysb;           
        
              
%     % 其他角度不需算BM                

        % calculate BM of all frames for each beads
        stdax=nanstd(organizedx);
        stday=nanstd(organizedy);             
                    
        % calculate xy ratio and write xy ratio and BM of all frames (x_y_ratio & stdax,stday)
        result(j,:)=[stdax./stday];
    end
end
        
    %result 全部跑完再一次存          
    xlswrite(filename,result,'xy ratio');
    xlswrite(filename,[organizedx zeros(length(organizedx),1) organizedy],'xy position');

    YCH=0.1*number_of_frames;
    a=size(result)    
for i=1:number_of_beads    
    if length(find(result(:,i)>=0.8 & result(:,i)<=1.2))==6 & sum(isnan(organizedx(:,i)))<YCH & sum(isnan(organizedy(:,i)))<YCH
        result2(:,i)=result(:,i); %若轉所有角度都符合, 存xy,xyratio,圖
        BMxy2(:,i)=BMxy(:,i);
        plot(-organizedx(:,i),organizedy(:,i),'o')
        xlabel('x position (um)')
        ylabel('y position (um)')
        saveas(gcf,['aoi' num2str(i) '.jpg'])
    else   % 若不符合,去掉補0,不存圖
        result2(:,i)=zeros(6,1);
        BMxy2(:,i)=zeros(3,1);
    end
end

xlswrite(['2' filename],BMxy2,'BM xy all-frames');
xlswrite(['2' filename],result2,'xy ratio');
        
