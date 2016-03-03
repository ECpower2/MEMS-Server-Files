% Program for reading data from the fiber optics (Luna System)
% Developed by Fabricio Ribeiro
% 08-April-2015

function principal
clear;
home;
warning off;
clear global;

%% ------------------------ INPUTS FROM USER -----------------------------

% Output file
filename='ResultsSpecimen2-2.txt';
% Information about regions of measured data from fiber
regions=5; % quantity of regions
initialpos=zeros(1,regions);
finalpos=zeros(1,regions);
% Initial and final position of measuring region on the fiber (in meters)
% % initialpos(1)=1.548; finalpos(1)=1.660;
% % initialpos(2)=1.683; finalpos(2)=1.798;
% % initialpos(3)=1.951; finalpos(3)=2.038;     % NRC1-2
% % initialpos(4)=2.061; finalpos(4)=2.164;
% % initialpos(5)=2.206; finalpos(5)=2.308;

initialpos(1)=0.370; finalpos(1)=0.427;
initialpos(2)=0.470; finalpos(2)=0.527;
initialpos(3)=0.560; finalpos(3)=0.615;     % NRC2-2
initialpos(4)=0.670; finalpos(4)=0.720;
initialpos(5)=0.761; finalpos(5)=0.815;

% Minimum and maximum values for strain data
minstrain=6500; maxstrain=11000;
% % % Strain levels to observe crack growth
% % levela=8500; levelb=8200; levelc=7800;


%% -------------------------- FILE READING -------------------------------

% Opening, reading and closing file
fid = fopen(filename);
rawdata=fscanf(fid,'%c');
fclose(fid);

% Changing invalid values from raw data and creating new file
% OBS.: 1.#QNAN represents an invalid value from Luna System
content=strrep(rawdata,'1.#QNAN','-111.111');
newfile='data_temp.txt';
output=fopen(newfile,'w+');
fprintf(output,'%s ',content);
fclose(output);
clear content;

% Command importdata doesn't work when it finds an invalid value
delimiterIn = '\t';
rawdata=importdata(newfile,delimiterIn);
delete(newfile);

% Separating the data
% Variable "data" has first row with fiber position and each following
  % row with the strain measurements per sample
data=rawdata.data;
% % data=dlmread(newfile,'',4,1); % this command could read the data
    % % directly with no need to use "importdata"

% Variable "timestamp" has the date and time when each sample was taken
timestamp=rawdata.textdata;
clear rawdata;
for i=1:1:5 % to eliminate the initial text
    timestamp(1)=[];
end

%% ------------------------ ORGANIZING DATA ------------------------------

% Selecting the data of interest
% % regions=input('How many regions of measurement are there in the fiber?\n   ');
% % for i=1:1:regions
% %     disp(sprintf('\n Region number %d:',i));
% %     initialpos(i)=input('What is the region''s initial position on the fiber?\n   ');
% %     finalpos(i)=input('What is the region''s final position on the fiber?\n   ');
% % end

% Deleting unnecessary data
j=1;
for i=1:1:regions
    while data(1,j)<=finalpos(i)
        if data(1,j)<=initialpos(i)
            data(:,j)=[]; % delete data before initial position
        else
            j=j+1;
        end
    end
    if i==regions
        [m,n]=size(data);
        while j<n
            data(:,j)=[];
            [m,n]=size(data);
        end
    end
end
data(:,j)=[];
[m,n]=size(data);
olddata=data; % keep old data to evaluate bad data cleaning process

% Converting bad data for average value
bad_data(1:m)=0;
for i=2:1:m
    for j=1:1:n
        if bad_data(i)<n && ((data(i,j)<minstrain) || (data(i,j)>maxstrain))
            count=1;
            found=0;
% %             if i==31 % to check data correction with a sample
% %                 disp('i = 31')
% %             end
            while found==0
                if bad_data(i)>=n % all data is bad, no need to count again
                    found=1;
                elseif count==n-1 %all data is bad
                    found=1;
                    data(i,:)=0; % set whole sample as zero strain
                    count=count+1;
                elseif (j+count<n) && ((data(i,j+count)<minstrain) || ...
                          (data(i,j+count)>maxstrain))
                        count=count+1;
                elseif j==1 % if it is the beginning of the file
                    found=1;
                    for k=1:1:count
                        data(i,k)=data(i,count+1);
                    end
                elseif j+count>=n % if it is the end of the file
                    found=1;
                    for k=1:1:count
                        data(i,j-1+k)=data(i,j-1);
                    end
                else
                    found=1;
                    increment=(data(i,j+count)-data(i,j-1))/(count+1);
                    for k=1:1:count
                        data(i,j-1+k)=data(i,j-1)+k*increment;
                    end
                end
            end
            bad_data(i)=bad_data(i)+count;
        end
    end
end
% Variable for evaluating how bad (%) the data was for each sample
bad_data(1:m)=bad_data(1:m)*100/n;
bad_data(1)=100; %it's not a sample, it's the fiber distance

% % % Comparing results after data cleaning process
% % sample=41;
% % figure()
% % hold on
% % plot(olddata(1,:),olddata(sample+1,:))
% % title(['Sample ',int2str(sample)]);
% % plot(data(1,:),data(sample+1,:),'r')
clear olddata

% Calculating number of cycle for each sample
cycle=zeros(1,m-1);
for i=1:1:(m-1)
    cycle(i)=sample_cycle(i);
end

% Deleting samples with more than 50% of bad data
i=2;
while i<=m % m-1 is the samples quantity
    if bad_data(i)>50 || cycle(i-1)==0
        bad_data(i)=[];
        cycle(i-1)=[];
        data(i,:)=[];
        timestamp(i-1)=[];
        m=size(bad_data);
        m=m(2);
    else
        i=i+1;
    end
end

% Separating each region
% % tic
i=1;
for j=1:1:regions
    k=1;
    found=0;
    while found==0
        if data(1,i)>=initialpos(j) && data(1,i)<=finalpos(j)
            region(j).position(k)=data(1,i);
            for p=2:1:m
                % strain(x,y) = strain at position(y) for sample x
                region(j).strain(p-1,k)=data(p,i);
            end
            k=k+1; i=i+1;
            if i>n
                found=1;
            end
        else
            found=1;
        end
    end
end
m=m-1; % actual samples quantity
% % toc

% Correcting flutuations of data (sudden change of more than 20% that comes
%   back to the anterior value)




% % Convert string to date variable
% % formatOut = 'mm/dd/yy';
% % date=datestr(datenum({'2015-03-17T10:06:10.896371';'2015-03-17T12:07:04.123559'}, ...
% %     'yyyy-mm-ddTHH:MM:SS.FFFFFF'),formatOut);

%% ---------------------- SEEING CRACK GROWTH ----------------------------

% Get screen size
scrsz = get(0,'ScreenSize');
% % figure position [left bottom width height]

% SEE STRAIN AT EVERY REGION OF ONE SAMPLE
% % i=1; % 'sample' number
% % figure('Position',[1 1 scrsz(3)-10 scrsz(4)-60])
% % for k=1:1:regions
% %     subplot(2,round(regions/2),k)
% %     if k==4 || k==5
% %         plot(region(k).position(end:-1:1),region(k).strain(i,:),'LineWidth',1.5);
% %     else
% %         plot(region(k).position,region(k).strain(i,:),'LineWidth',1.5);
% %     end
% % %     axis([region(k).position(1) region(k).position(end) 7000 9500])
% %     axis([region(k).position(1)-0.01 region(k).position(end)+0.01 6000 11000])
% %     title(['Region ',int2str(k)])
% %     grid on
% % end

% REGION ANIMATION
figure('Position',[1 1 scrsz(3)-10 scrsz(4)-90])
for i=1:1:m
    set(gcf,'Name',['Sample ',int2str(i)]);
    for k=1:1:regions
        subplot(2,round(regions/2),k)
        if k==4 || k==5
            plot(region(k).position(end:-1:1),region(k).strain(i,:),'LineWidth',1.5);
        else
            plot(region(k).position,region(k).strain(i,:),'LineWidth',1.5);
        end
        axis([region(k).position(1)-0.01 region(k).position(end)+0.01 minstrain maxstrain])
        title(['Region ',int2str(k)])
        grid on
    end
    pause(0.02)
end


% % % TO TEST THE DERIVATIVES OF THE STRAIN AND TO VERIFY LEVELS
% % k=5; % region 3
% % i=418; % sample number
% % % for i=1:100:501
% %     
% % y=region(k).strain(i,:);
% % figure('Position',[i 1 scrsz(3)/2 scrsz(4)-60],'Name',['Sample ',int2str(i)])
% % ax1=subplot(3,1,1);
% % plot(region(k).position,y);
% % grid on
% % grid minor
% % hold on
% % ys=smooth(region(k).position,y);
% % plot(region(k).position,ys,'r');
% % axis([region(k).position(1)-0.01 region(k).position(end)+0.01 6500 10000])
% % 
% % ax2=subplot(3,1,2);
% % dy=diff(ys)./diff(region(k).position');
% % dys=smooth(region(k).position(1:end-1),dy);
% % plot(region(k).position(1:end-1),dy,'b');
% % grid on
% % grid minor
% % hold on
% % plot(region(k).position(1:end-1),dys,'m');
% % xlim([region(k).position(1)-0.01 region(k).position(end)+0.01])
% % 
% % ax3=subplot(3,1,3);
% % dy2=diff(dys)./diff(region(k).position(1:end-1)');
% % dy2s=smooth(region(k).position(1:end-2),dy2);
% % plot(region(k).position(1:end-2),dy2,'b');
% % grid on
% % grid minor
% % hold on
% % plot(region(k).position(1:end-2),dy2s,'m');
% % xlim([region(k).position(1)-0.01 region(k).position(end)+0.01])
% % linkaxes([ax1,ax2,ax3],'x');
% % 
% % % end

%% -------------------- IDENTIFYING CRACK GROWTH -------------------------

% METHOD 1: seek for local maximum and minimum by using derivative
crack1=zeros(m,regions); %crack size from method 1
crackposmin=zeros(m,regions); %crack position from method 1
crackposmax=zeros(m,regions); %crack position from method 1
% METHOD 2: seek grow of fiber position on fixed strain level
% levela=8500; levelb=8200; levelc=7800;
crack2a=zeros(m,regions); %crack size at 'levela' microstrain
crack2b=zeros(m,regions); %crack size at 'levelb' microstrain
crack2c=zeros(m,regions); %crack size at 'levelc' microstrain
% ...crack(i,k) size in mm for sample i and region k

% tic
for i=1:1:m
    for k=1:1:regions
        x=region(k).position;
        y=region(k).strain(i,:);
        ys=smooth(x,y);
        dy=diff(ys)./diff(x'); % derivative of strain distribution
        [dymax,posmax]=max(dy); % position of maximum value
        [dymin,posmin]=min(dy);
        % crack size in mm for sample i and region k
        crack1(i,k)=(x(posmin)-x(posmax))*1000;
        crackposmin(i,k)=posmin;
        crackposmax(i,k)=posmax;
        crack2a(i,k)=1000*(x(find(y>=levela,1,'last'))-x(find(y>=levela,1)));
        crack2b(i,k)=1000*(x(find(y>=levelb,1,'last'))-x(find(y>=levelb,1)));
        crack2c(i,k)=1000*(x(find(y>=levelc,1,'last'))-x(find(y>=levelc,1)));
   % to remove bad points of crack: less than 15mm and above 52mm
        if crack1(i,k)<15 || crack1(i,k)>55
            crack1(i,k)=NaN;
        end
        if crack2a(i,k)<5 || crack2a(i,k)>70
            crack2a(i,k)=NaN;
        end
        if crack2b(i,k)<5 || crack2b(i,k)>70
            crack2b(i,k)=NaN;
        end
        if crack2c(i,k)<5 || crack2c(i,k)>70
            crack2c(i,k)=NaN;
        end
    end
end
% toc

% Plot crack growth from METHOD 1
figure()
plot(cycle,crack1(:,1),'b*')
hold on
plot(cycle,crack1(:,2),'rs')
plot(cycle,crack1(:,3),'kv')
plot(cycle,crack1(:,4),'gx')
plot(cycle,crack1(:,5),'mo')
% legend('Region 1','Region 2','Region 3','Region 4','Region 5',...
%     'Location','northwest','Orientation','horizontal')
legend('Region 1','Region 2','Region 3','Region 4','Region 5',...
    'Location','best')
axis([0 1.2*cycle(end) 10 70])

maxcrack=max(max(crack2c(:,:)));
mincrack=min(min(crack2c(:,:)));

% Plot crack growth from METHOD 2
figure('Position',[5 scrsz(4)/2-100 scrsz(3)-10 scrsz(4)/2-10])
subplot(1,3,1)
plot(cycle,crack2a(:,1),'b*')
hold on
grid on
plot(cycle,crack2a(:,2),'rs')
plot(cycle,crack2a(:,3),'kv')
plot(cycle,crack2a(:,4),'gx')
plot(cycle,crack2a(:,5),'mo')
legend('Region 1','Region 2','Region 3','Region 4','Region 5',...
    'Location','best')
% axis([0 1.2*cycle(end) 0.5*mincrack 1.2*maxcrack])
axis([0 1.2*cycle(end) 10 70])

subplot(1,3,2)
plot(cycle,crack2b(:,1),'b*')
hold on
grid on
plot(cycle,crack2b(:,2),'rs')
plot(cycle,crack2b(:,3),'kv')
plot(cycle,crack2b(:,4),'gx')
plot(cycle,crack2b(:,5),'mo')
legend('Region 1','Region 2','Region 3','Region 4','Region 5',...
    'Location','best')
% axis([0 1.2*cycle(end) 0.5*mincrack 1.2*maxcrack])
axis([0 1.2*cycle(end) 10 70])

subplot(1,3,3)
plot(cycle,crack2c(:,1),'b*')
hold on
grid on
plot(cycle,crack2c(:,2),'rs')
plot(cycle,crack2c(:,3),'kv')
plot(cycle,crack2c(:,4),'gx')
plot(cycle,crack2c(:,5),'mo')
legend('Region 1','Region 2','Region 3','Region 4','Region 5',...
    'Location','best')
% axis([0 1.2*cycle(end) 0.5*mincrack 1.2*maxcrack])
axis([0 1.2*cycle(end) 10 70])

% Plot 3D graphic of strain distribution over cycles
figure()
surf(region(t).position,cycle,region(t).strain,'EdgeColor','none')

% % figure('Position',[1 1 scrsz(3)-10 scrsz(4)-60])
% % for i=1:1:m
% %     set(gcf,'Name',['Sample ',int2str(i)]);
% %     for k=1:1:regions
% %         subplot(2,round(regions/2),k)
% %         plot(region(k).position,region(k).strain(i,:));
% %         axis([region(k).position(1)-0.01 region(k).position(end)+0.01 minstrain maxstrain])
% %         grid on
% %     end
% %     pause(0.02)
% % end




function N = sample_cycle(sam)
% function to relate the Luna sample number to the test cycle number
% values obtained from curve fitting from Excel file of data pointed out
   % during test
if sam<9
    N=0;
elseif (sam>=9) && (sam<=17)
    N=round(500*sam-4000);
elseif (sam>17) && (sam<=57)
    N=round(3751.228501*sam-61974.20147);
elseif (sam>57) && (sam<=213)
    N=round(4488.372402*sam-91856.67075);
elseif (sam>213) && (sam<=255)
    N=round(715.2380952*sam+692414.2857);
elseif (sam>255) && (sam<=352)
    N=round(4455.941808*sam-263032.6588);
elseif (sam>352) && (sam<=378)
    N=round(3855.131115*sam-52981.4364);
elseif (sam>378) && (sam<=603)
    N=round(5228.864834*sam-600685.7376);
else
    N=-1500;
end
N=N+1500; %1500 initial cycles not accounted

% % % To test the curve
% % N1=[500 1000 3500 4000 4500 9500 34500 49500 69500 94500 124500 159500 ...
% %     364620 529670 599690 799750 824750 844760 874800 914800 949795  ...
% %     1279895 1304900 1344914 1404900 1685016 1705022 1710024 2495259 ...
% %     2500261 2540272 2550275];
% % sample=[9 10 15 16 17 18 25 31 35 44 50 57 98 139 154 196 203 213 255 ...
% %     264 273 346 352 363 378 439 444 445 591 592 600 603];

% % for j=1:1:603
% %     model(j)=sample_cycle(j);
% % end

% % figure()
% % hold on
% % plot(sample,N1,'+')
% % plot(1:603,model,'r')



   