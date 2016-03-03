function DICcomp_blade()
% compares DIC and MEMS results for blade shape

% select files
disp = input('Enter blade tip displacement: ','s');
[DICfiles,DICpath,~] = uigetfile(...
    'D:/acooperman/My Documents/testJuly/DIC/20150708/Test/*.csv',...
    'Select DIC files','MultiSelect','on');
nDIC = length(DICfiles);
[MEMSfile,MEMSpath,~] = ...
    uigetfile('D:/acooperman/My Documents/testJuly/MEMS/8July/*.csv',...
    'Select MEMS file');
cut = strfind(MEMSfile,'-node') - 1;
MEMSfile = MEMSfile(1:cut);
[reffile,refpath,~] = uigetfile(...
    'D:/acooperman/My Documents/testJuly/MEMS/8July/*.csv',...
    'Select MEMS reference file');
cut = strfind(reffile,'-node') - 1;
reffile = reffile(1:cut);
[outfile,outpath] = uiputfile(...
    'D:/acooperman/My Documents/testJuly/DIC-MEMS analysis/*.xlsx',...
    'Save output as');

% set analysis parameters
n_to_avg = 5; % number of MEMS samples to average
rs = 1295; % starting value in MEMS file
re = 1301; % ending value in MEMS file

% get blade gridpoints
bladegrid = dlmread(...
    'D:/acooperman/My Documents/WindChallenge/bladegrid.csv',',',1,0);
xgrid = -bladegrid(:,2)-.129;
ygrid = bladegrid(:,1);

% write header information
header = cell(6,2);
header{1,1} = 'tip deflection: '; header{1,2} = disp;
header{2,1} = 'DIC path: '; header{2,2} = [DICpath DICfiles{1}];
header{3,1} = 'MEMS file: '; header{3,2} = [MEMSpath MEMSfile];
header{4,1} = 'reference file: '; header{4,2} = [refpath reffile];
header{5,1} = '# MEMS samples averaged: '; header{5,2} = n_to_avg;
xlswrite([outpath outfile],header,1);

header2 = cell(11,6);
header2{1,1} = 'MEMS max time:';
header2{1,2} = re/100;
header2{1,3} = 'x (m)';
header2{1,4} = 'y (m)'; header2{1,5} = 'MEMS';
header2{1,6} = 'DIC'; 
header2{2,1} = 'p00'; header2{3,1} = 'p10';
header2{4,1} = 'p01'; header2{5,1} = 'p20';
header2{6,1} = 'p11'; header2{7,1} = 'p02';
header2{8,1} = 'p30'; header2{9,1} = 'p21';
header2{10,1} = 'p12'; header2{11,1} = 'rmse';
xlswrite([outpath outfile],header2,1,'A7');

% calculate blade shape from MEMS
[fMEMS,gof] = blade_shape_live([MEMSpath MEMSfile],[refpath reffile],rs,re);

% get blade shape from DIC and compare with MEMS
iDIC = zeros(nDIC,1); 
for i = 1:nDIC
    [~,~,~,~,~,W,sig,~,~,~,~,~,~,~,~,X,Y,~] ...
        = importDIC7([DICpath DICfiles{i}]);
    X = X(sig+1>0);
    Y = Y(sig+1>0);
    W = W(sig+1>0);
    X = X + 650 - max(X);  % shift maximum x location to 650 mm
    Wgrid = griddata(X,Y,W,1000*xgrid,1000*ygrid)/1000; % output in m
    sMEMS = fMEMS(xgrid,ygrid); 
    
    figure;
    plot3(xgrid,ygrid,Wgrid,'.')
    hold on
    plot3(xgrid,ygrid,sMEMS,'.')
        
    m = length(DICfiles{i}) - 8;
    iDIC(i) = str2double(DICfiles{i}(m:m+2));
end

% figure;
% plot(xlin,Wlin(1,:),xlin,Wlin(g/20,:),xlin,Wlin(g/10,:))
% hold on
% plot(xlin,sMEMS(1,:),'--',xlin,sMEMS(g/20,:),'--',xlin,sMEMS(g/10,:),'--')
% legend('DIC -','DIC 0','DIC +','MEMS -','MEMS 0','MEMS +')

xlswrite([outpath outfile],[fMEMS.p00;fMEMS.p10;fMEMS.p01;fMEMS.p20;...
    fMEMS.p11;fMEMS.p02;fMEMS.p30;fMEMS.p21;fMEMS.p12;gof.rmse],1,'B7');
xlswrite([outpath outfile],[xgrid ygrid sMEMS Wgrid],1,'C8');