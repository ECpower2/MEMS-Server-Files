function [time,EqKm_x,EqKm_y,EqKm_z,Sens_x,Sens_y,Sens_z,a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,J] = importpp(filename, startRow, endRow)
% Import post-process files generated by mems_Kalman_postprocess.m

%IMPORTFILE Import numeric data from a text file as column vectors.
%   [TIME,EQKM_X,EQKM_Y,EQKM_Z,SENS_X,SENS_Y,SENS_Z,A_X,A_Y,A_Z,M_X,M_Y,M_Z,G_X,G_Y,G_Z,KM_G_X,KM_G_Y,KM_G_Z,QKM_W,QKM_X,QKM_Y,QKM_Z,J]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [TIME,EQKM_X,EQKM_Y,EQKM_Z,SENS_X,SENS_Y,SENS_Z,A_X,A_Y,A_Z,M_X,M_Y,M_Z,G_X,G_Y,G_Z,KM_G_X,KM_G_Y,KM_G_Z,QKM_W,QKM_X,QKM_Y,QKM_Z,J]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [time,EqKm_x,EqKm_y,EqKm_z,Sens_x,Sens_y,Sens_z,a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,J]
%   = importfile('beam-25mm4-node5-post-process.csv',2, 1190);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/02/23 11:33:30

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
%   column13: double (%f)
%	column14: double (%f)
%   column15: double (%f)
%	column16: double (%f)
%   column17: double (%f)
%	column18: double (%f)
%   column19: double (%f)
%	column20: double (%f)
%   column21: double (%f)
%	column22: double (%f)
%   column23: double (%f)
%	column24: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
time = dataArray{:, 1};
EqKm_x = dataArray{:, 2};
EqKm_y = dataArray{:, 3};
EqKm_z = dataArray{:, 4};
Sens_x = dataArray{:, 5};
Sens_y = dataArray{:, 6};
Sens_z = dataArray{:, 7};
a_x = dataArray{:, 8};
a_y = dataArray{:, 9};
a_z = dataArray{:, 10};
m_x = dataArray{:, 11};
m_y = dataArray{:, 12};
m_z = dataArray{:, 13};
g_x = dataArray{:, 14};
g_y = dataArray{:, 15};
g_z = dataArray{:, 16};
Km_g_x = dataArray{:, 17};
Km_g_y = dataArray{:, 18};
Km_g_z = dataArray{:, 19};
qKm_w = dataArray{:, 20};
qKm_x = dataArray{:, 21};
qKm_y = dataArray{:, 22};
qKm_z = dataArray{:, 23};
J = dataArray{:, 24};


