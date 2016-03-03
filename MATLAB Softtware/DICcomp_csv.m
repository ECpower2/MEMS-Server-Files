function DICcomp()
% compares DIC and MEMS results for beam shape

disp = input('Enter beam tip displacement: ','s');
[DICfiles,DICpath,~] = uigetfile('D:/acooperman/Desktop/DIC/*.csv',...
    'Select DIC files','MultiSelect','on');
nDIC = length(DICfiles);
[MEMSfile,MEMSpath,~] = ...
    uigetfile('D:/acooperman/My Documents/Luna beam/test May/*.csv',...
    'Select MEMS file');
cut = strfind(MEMSfile,'-node') - 1;
MEMSfile = MEMSfile(1:cut);
g = 300; % # grid points for DIC along x- and y-axes
n_to_avg = 5; % number of MEMS samples to average

[outfile,outpath] = uiputfile(...
    'D:/acooperman/Desktop/DIC-MEMS analysis/*.csv','Save output as');

% write header information
fid = fopen([outpath outfile],'w');
hline1 = ['tip deflection: ',disp];
fprintf(fid,'%s\n',hline1);
hline2 = ['DIC path: ',DICpath DICfiles{1}];
fprintf(fid,'%s\n',hline2);
hline3 = ['MEMS file: ',MEMSpath,MEMSfile];
fprintf(fid,'%s\n',hline3);
hline4 = ['# MEMS samples averaged: ',num2str(n_to_avg)];
fprintf(fid,'%s\n',hline4);
hline5 = ['# points along axis: ',num2str(g)];
fprintf(fid,'%s\n',hline5);
hline6 = 'MEMS time until:,15,,';
fprintf(fid,'%s\n',hline6);
hline7 = 'DIC files,MSE,NRMSE,NMSE';
fprintf(fid,'%s\n',hline7);
fclose(fid);

for i = 1:nDIC
    [mse,nrmse,nmse] = shapecomp([DICpath DICfiles{i}],MEMSfile);
    j = length(DICfiles{i}) - 8;
    iDIC = str2double(DICfiles{i}(j:j+2));
    dlmwrite([outpath outfile],[iDIC mse nrmse nmse],'-append');
end