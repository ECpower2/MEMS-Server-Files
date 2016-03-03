function DICcomp_torsion()
% compares DIC and MEMS results for beam shape

% select files
disp = input('Enter beam tip displacement: ','s');
[DICfiles,DICpath,~] = uigetfile(...
    'D:/acooperman/My Documents/testMay/DIC/20150521/test/output/*.csv',...
    'Select DIC files','MultiSelect','on');
nDIC = length(DICfiles);
[MEMSfile,MEMSpath,~] = ...
    uigetfile('D:/acooperman/My Documents/testMay/MEMS/21May/*.csv',...
    'Select MEMS file');
cut = strfind(MEMSfile,'-node') - 1;
MEMSfile = MEMSfile(1:cut);
[outfile,outpath] = uiputfile(...
    'D:/acooperman/My Documents/testMay/DIC-MEMS analysis/*.xlsx',...
    'Save output as');

% set analysis parameters
g = 300; % # grid points for DIC along x- and y-axes
n_to_avg = 5; % number of MEMS samples to average
rs = 1295; % starting value in MEMS file
re = 1301; % ending value in MEMS file

% write header information
header = cell(5,2);
header{1,1} = 'tip deflection: '; header{1,2} = disp;
header{2,1} = 'DIC path: '; header{2,2} = [DICpath DICfiles{1}];
header{3,1} = 'MEMS file: '; header{3,2} = [MEMSpath MEMSfile];
header{4,1} = '# MEMS samples averaged: '; header{4,2} = n_to_avg;
header{5,1} = '# points along axis: '; header{5,2} = g;
xlswrite([outpath outfile],header,1);

header2 = cell(11,9);
header2{1,1} = 'MEMS max time:';
header2{1,2} = re/100;
header2{1,3} = 'x (mm)';
header2{1,4} = 'DIC -edge'; header2{1,5} = 'DIC center';
header2{1,6} = 'DIC +edge'; header2{1,7} = 'MEMS -edge';
header2{1,8} = 'MEMS center'; header2{1,9} = 'MEMS +edge';
header2{2,1} = 'p00'; header2{3,1} = 'p10';
header2{4,1} = 'p01'; header2{5,1} = 'p20';
header2{6,1} = 'p11'; header2{7,1} = 'p02';
header2{8,1} = 'p30'; header2{9,1} = 'p21';
header2{10,1} = 'p12'; header2{11,1} = 'rmse';
xlswrite([outpath outfile],header2,1,'A6');

% calculate beam shape from MEMS
[fMEMS,gof] = beam_shape_live_torsion([MEMSpath MEMSfile],rs,re);

% get beam shape from DIC and compare with MEMS
iDIC = zeros(nDIC,1); 
for i = 1:nDIC
    [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,X,Y,Z] ...
        = importDIC([DICpath DICfiles{i}]);
    X = X - min(X);
    xlin = linspace(0,max(X),g);
    ylin = linspace(min(Y),max(Y),g);
    [Xlin,Ylin] = meshgrid(xlin,ylin);
    fDIC = scatteredInterpolant(X,Y,Z);
    Zlin = fDIC(Xlin,Ylin);
    sMEMS = fMEMS(Xlin/1000,Ylin/1000)*1000; % output in mm
    
    % shift DIC such that clamped end begins at origin
%     [zmax,imax] = max(Zlin(g/2,:));
%     xmax = xlin(imax);
%     z0 = Zlin(g/2,1);
%     theta = 2*tan((zmax - z0)/xmax);
%     R = roty(theta*180/pi);
%     xrot = reshape(Xlin,1,g^2);
%     yrot = reshape(Ylin,1,g^2);
%     zrot = reshape(Zlin,1,g^2);
%     mDIC = R*[xrot;yrot;zrot];
%     Xlin = reshape(mDIC(1,:)' - mDIC(1,1),g,g);
%     Zlin = reshape(mDIC(3,:)' - mDIC(3,1),g,g);
%     figure;
%     mesh(Xlin,Ylin,Zlin,C)
%     hold on
%     mesh(Xlin,Ylin,sMEMS,C)
        
    m = length(DICfiles{i}) - 8;
    iDIC(i) = str2double(DICfiles{i}(m:m+2));
end

figure;
plot(xlin,Zlin(1,:),xlin,Zlin(g/2,:),xlin,Zlin(g,:))
hold on
plot(xlin,sMEMS(1,:),'--',xlin,sMEMS(g/2,:),'--',xlin,sMEMS(g,:),'--')
legend('DIC -','DIC 0','DIC +','MEMS -','MEMS 0','MEMS +')

xlswrite([outpath outfile],[fMEMS.p00;fMEMS.p10;fMEMS.p01;fMEMS.p20;...
    fMEMS.p11;fMEMS.p02;fMEMS.p30;fMEMS.p21;fMEMS.p12;gof.rmse],1,'B7');
xlswrite([outpath outfile],[xlin;Zlin(1,:);Zlin(g/2,:);Zlin(g,:);...
    sMEMS(1,:);sMEMS(g/2,:);sMEMS(g,:)]',1,'C7');