function DICcomp_multi()
% compares DIC and MEMS results for beam shape

% select files
disp = input('Enter beam tip displacement: ','s');
[DICfiles,DICpath,~] = uigetfile(...
    'D:/acooperman/My Documents/testMay/DIC/20150520/test/output/*.csv',...
    'Select DIC files','MultiSelect','on');
nDIC = length(DICfiles);
[MEMSfile,MEMSpath,~] = ...
    uigetfile('D:/acooperman/My Documents/testMay/MEMS/20May/*.csv',...
    'Select MEMS file');
cut = strfind(MEMSfile,'-node') - 1;
MEMSfile = MEMSfile(1:cut);
[outfile,outpath] = uiputfile(...
    'D:/acooperman/My Documents/testMay/DIC-MEMS analysis/*.xlsx',...
    'Save output as');

% set analysis parameters
g = 300; % # grid points for DIC along x- and y-axes
n_to_avg = 5; % number of MEMS samples to average
rs = 295; % starting value in MEMS file
rf = 501; % final value in MEMS file
spacing = 100; % separation between sampled MEMS values
nMEMS = ceil((rf-rs)/spacing);
re = rs + n_to_avg;

% write header information
header = cell(5,2);
header{1,1} = 'tip deflection: '; header{1,2} = disp;
header{2,1} = 'DIC path: '; header{2,2} = [DICpath DICfiles{1}];
header{3,1} = 'MEMS file: '; header{3,2} = [MEMSpath MEMSfile];
header{4,1} = '# MEMS samples averaged: '; header{4,2} = n_to_avg;
header{5,1} = '# points along axis: '; header{5,2} = g;
xlswrite([outpath outfile],header,1);
xlswrite([outpath outfile],header,2);

statsheader = cell(3,3*nMEMS+1);
statsheader{1,1} = 'MEMS max time:';
statsheader{2,1} = 'DIC files';
for i=1:nMEMS
    statsheader{1,3*i-1} = (re + (i-1)*spacing)/100;
    statsheader{2,3*i-1} = 'MSE';
    statsheader{2,3*i} = 'NRMSE'; 
    statsheader{2,3*i+1} = 'NMSE';
end
xlswrite([outpath outfile],statsheader,1,'A6');

beamsheader = cell(5,nMEMS+1);
beamsheader{1,1} = 'MEMS max time:';
for i = 1:nMEMS
    beamsheader{1,i+1} = (re + (i-1)*spacing)/100;
end
beamsheader{2,1} = 'p1'; beamsheader{3,1} = 'p2';
beamsheader{4,1} = 'p3'; beamsheader{5,1} = 'rsq';
xlswrite([outpath outfile],beamsheader,2,'A6');

% calculate beam shape from MEMS
p1 = zeros(1,nMEMS); p2 = p1; p3 = p1; rsq = p1; k = 1;
while re < rf
    [p1(k),p2(k),p3(k),rsq(k)] = beam_shape_live([MEMSpath MEMSfile],rs,re);
    k = k+1;
    rs = re + spacing - n_to_avg;
    re = re + spacing;
end
p1 = p1/3e6;    p2 = p2/2e3;    % change units from meters to mm

% get beam shape from DIC and compare with MEMS
iDIC = zeros(nDIC,1); 
mse = zeros(nDIC,nMEMS); nrmse = mse; nmse = mse;
% c1x = zeros(g,nDIC); c2y = c1x; angle = c1x;
beams = zeros(g,nMEMS);
for i = 1:nDIC
    [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,c1,c2,gamma,X,Y,Z] ...
        = importDIC([DICpath DICfiles{i}]);
    X = X - min(X);
    xlin = linspace(0,max(X),g);
    ylin = linspace(min(Y),max(Y),g);
    [Xlin,Ylin] = meshgrid(xlin,ylin);
    f = scatteredInterpolant(X,Y,Z);
    Zlin = f(Xlin,Ylin);
    Zlin = Zlin - Zlin(g/2,1);
    
    for j = 1:nMEMS
        beams(:,j) = -(p1(j)*xlin.^3+p2(j)*xlin.^2+p3(j)*xlin);
        mse(i,j) = goodnessOfFit(beams(:,j),Zlin(g/2,:)','MSE');
        nrmse(i,j) = goodnessOfFit(beams(:,j),Zlin(g/2,:)','NRMSE');
        nmse(i,j) = goodnessOfFit(beams(:,j),Zlin(g/2,:)','NMSE');
    end
        
%     figure;
%     surf(Xlin,Ylin,Zlin)
%     shading flat
%     colormap jet
%     hold on
%     plot3(xlin,zeros(g,1),beams(:,nMEMS),'k')
   
    m = length(DICfiles{i}) - 8;
    iDIC(i) = str2double(DICfiles{i}(m:m+2));
%     c1x(:,i) = c1;
%     c2y(:,i) = c2;
%     angle(:,i) = gamma;
end

figure;
plot(xlin,beams(:,nMEMS))
hold on
plot(xlin,Zlin(g/2,:))

stats = zeros(nDIC,3*nMEMS);
for j=1:nMEMS
    stats(:,3*j-2) = mse(:,j);
    stats(:,3*j-1) = nrmse(:,j);
    stats(:,3*j) = nmse(:,j);
end
xlswrite([outpath outfile],[iDIC stats],1,'A8');
xlswrite([outpath outfile],[p1; p2; p3; rsq],2,'B7');