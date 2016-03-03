function DICcomp()
% compares DIC and MEMS results for beam shape

% select files
disp = input('Enter beam tip displacement: ','s');
[DICfiles,DICpath,~] = uigetfile(...
    'D:/acooperman/My Documents/testMay/DIC/*.csv',...
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
rf = 1500; % final value in MEMS file
rs = rf - n_to_avg;

% write header information
header = cell(5,2);
header{1,1} = 'tip deflection: '; header{1,2} = disp;
header{2,1} = 'DIC path: '; header{2,2} = [DICpath DICfiles{1}];
header{3,1} = 'MEMS file: '; header{3,2} = [MEMSpath MEMSfile];
header{4,1} = '# MEMS samples averaged: '; header{4,2} = n_to_avg;
header{5,1} = '# points along axis: '; header{5,2} = g;
xlswrite([outpath outfile],header,1);
xlswrite([outpath outfile],header,2);

statsheader = cell(2,4);
statsheader{1,1} = 'MEMS max time:'; statsheader{1,2} = 15;
statsheader{2,1} = 'DIC files'; statsheader{2,2} = 'MSE';
statsheader{2,3} = 'NRMSE'; statsheader{2,4} = 'NMSE';
xlswrite([outpath outfile],statsheader,1,'A6');

% calculate beam shape from MEMS
[p1,p2,p3,rsq] = beam_shape_live(MEMSfile,rs,rf);
p1 = p1/3e6;    p2 = p2/2e3;    % change units from meters to mm

% get beam shape from DIC
iDIC = zeros(nDIC,1); mse = iDIC; nrmse = mse; nmse = mse;
xDIC = zeros(g,nDIC); beam = xDIC; zDIC = xDIC;
c1x = xDIC; c2y = xDIC; angle = xDIC;
for i = 1:nDIC
    [~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,c1,c2,gamma,X,Y,Z] ...
        = importDIC([DICpath DICfiles{i}]);
    X = X - min(X);
    xlin = linspace(0,max(X),g);
    ylin = linspace(min(Y),max(Y),g);
    [Xlin,Ylin] = meshgrid(xlin,ylin);
    f = scatteredInterpolant(X,Y,Z);
    Zlin = f(Xlin,Ylin);
    j = length(DICfiles{i}) - 8;
    iDIC(i) = str2double(DICfiles{i}(j:j+2));
    xDIC(:,i) = xlin;
    zDIC(:,i) = Zlin(g/2,:); % evaluate at centerline
    beam(:,i) = -(p1*xlin.^3+p2*xlin.^2+p3*xlin);
    mse(i) = goodnessOfFit(beam(:,i),Zlin(g/2,:)','MSE');
    nrmse(i) = goodnessOfFit(beam(:,i),Zlin(g/2,:)','NRMSE');
    nmse(i) = goodnessOfFit(beam(:,i),Zlin(g/2,:)','NMSE');
    c1x(:,i) = c1;
    c2y(:,i) = c2;
    angle(:,i) = gamma;
    
    figure;
    surf(Xlin,Ylin,Zlin)
    shading flat
    colormap jet
    hold on
    plot3(xlin,zeros(g,1),beam(:,nMEMS),'k')

    figure;
    plot(xlin,beam)
    hold on
    plot(xlin,Zlin(g/2,:))
end

% write data to spreadsheet
xlswrite([outpath outfile],[iDIC mse nrmse nmse],1,'A8');









