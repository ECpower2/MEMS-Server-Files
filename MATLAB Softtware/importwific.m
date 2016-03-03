function [time1,Node01Gqw1,Node01Gqx1,Node01Gqy1,Node01Gqz1,Node01Lqw1,Node01Lqx1,Node01Lqy1,Node01Lqz1,Node01rx1,Node01ry1,Node01rz1,Node01lx1,Node01ly1,Node01lz1,Node01ax1,Node01ay1,Node01az1,Node01mx1,Node01my1,Node01mz1,Node01gx1,Node01gy1,Node01gz1,Node01temp1,Node02Gqw1,Node02Gqx1,Node02Gqy1,Node02Gqz1,Node02Lqw1,Node02Lqx1,Node02Lqy1,Node02Lqz1,Node02rx1,Node02ry1,Node02rz1,Node02lx1,Node02ly1,Node02lz1,Node02ax1,Node02ay1,Node02az1,Node02mx1,Node02my1,Node02mz1,Node02gx1,Node02gy1,Node02gz1,Node02temp1,Node03Gqw1,Node03Gqx1,Node03Gqy1,Node03Gqz1,Node03Lqw1,Node03Lqx1,Node03Lqy1,Node03Lqz1,Node03rx1,Node03ry1,Node03rz1,Node03lx1,Node03ly1,Node03lz1,Node03ax1,Node03ay1,Node03az1,Node03mx1,Node03my1,Node03mz1,Node03gx1,Node03gy1,Node03gz1,Node03temp1,Node04Gqw1,Node04Gqx1,Node04Gqy1,Node04Gqz1,Node04Lqw1,Node04Lqx1,Node04Lqy1,Node04Lqz1,Node04rx1,Node04ry1,Node04rz1,Node04lx1,Node04ly1,Node04lz1,Node04ax1,Node04ay1,Node04az1,Node04mx1,Node04my1,Node04mz1,Node04gx1,Node04gy1,Node04gz1,Node04temp1,Node05Gqw1,Node05Gqx1,Node05Gqy1,Node05Gqz1,Node05Lqw1,Node05Lqx1,Node05Lqy1,Node05Lqz1,Node05rx1,Node05ry1,Node05rz1,Node05lx1,Node05ly1,Node05lz1,Node05ax1,Node05ay1,Node05az1,Node05mx1,Node05my1,Node05mz1,Node05gx1,Node05gy1,Node05gz1,Node05temp1] = importwific(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [TIME1,NODE01GQW1,NODE01GQX1,NODE01GQY1,NODE01GQZ1,NODE01LQW1,NODE01LQX1,NODE01LQY1,NODE01LQZ1,NODE01RX1,NODE01RY1,NODE01RZ1,NODE01LX1,NODE01LY1,NODE01LZ1,NODE01AX1,NODE01AY1,NODE01AZ1,NODE01MX1,NODE01MY1,NODE01MZ1,NODE01GX1,NODE01GY1,NODE01GZ1,NODE01TEMP1,NODE02GQW1,NODE02GQX1,NODE02GQY1,NODE02GQZ1,NODE02LQW1,NODE02LQX1,NODE02LQY1,NODE02LQZ1,NODE02RX1,NODE02RY1,NODE02RZ1,NODE02LX1,NODE02LY1,NODE02LZ1,NODE02AX1,NODE02AY1,NODE02AZ1,NODE02MX1,NODE02MY1,NODE02MZ1,NODE02GX1,NODE02GY1,NODE02GZ1,NODE02TEMP1,NODE03GQW1,NODE03GQX1,NODE03GQY1,NODE03GQZ1,NODE03LQW1,NODE03LQX1,NODE03LQY1,NODE03LQZ1,NODE03RX1,NODE03RY1,NODE03RZ1,NODE03LX1,NODE03LY1,NODE03LZ1,NODE03AX1,NODE03AY1,NODE03AZ1,NODE03MX1,NODE03MY1,NODE03MZ1,NODE03GX1,NODE03GY1,NODE03GZ1,NODE03TEMP1,NODE04GQW1,NODE04GQX1,NODE04GQY1,NODE04GQZ1,NODE04LQW1,NODE04LQX1,NODE04LQY1,NODE04LQZ1,NODE04RX1,NODE04RY1,NODE04RZ1,NODE04LX1,NODE04LY1,NODE04LZ1,NODE04AX1,NODE04AY1,NODE04AZ1,NODE04MX1,NODE04MY1,NODE04MZ1,NODE04GX1,NODE04GY1,NODE04GZ1,NODE04TEMP1,NODE05GQW1,NODE05GQX1,NODE05GQY1,NODE05GQZ1,NODE05LQW1,NODE05LQX1,NODE05LQY1,NODE05LQZ1,NODE05RX1,NODE05RY1,NODE05RZ1,NODE05LX1,NODE05LY1,NODE05LZ1,NODE05AX1,NODE05AY1,NODE05AZ1,NODE05MX1,NODE05MY1,NODE05MZ1,NODE05GX1,NODE05GY1,NODE05GZ1,NODE05TEMP1]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [TIME1,NODE01GQW1,NODE01GQX1,NODE01GQY1,NODE01GQZ1,NODE01LQW1,NODE01LQX1,NODE01LQY1,NODE01LQZ1,NODE01RX1,NODE01RY1,NODE01RZ1,NODE01LX1,NODE01LY1,NODE01LZ1,NODE01AX1,NODE01AY1,NODE01AZ1,NODE01MX1,NODE01MY1,NODE01MZ1,NODE01GX1,NODE01GY1,NODE01GZ1,NODE01TEMP1,NODE02GQW1,NODE02GQX1,NODE02GQY1,NODE02GQZ1,NODE02LQW1,NODE02LQX1,NODE02LQY1,NODE02LQZ1,NODE02RX1,NODE02RY1,NODE02RZ1,NODE02LX1,NODE02LY1,NODE02LZ1,NODE02AX1,NODE02AY1,NODE02AZ1,NODE02MX1,NODE02MY1,NODE02MZ1,NODE02GX1,NODE02GY1,NODE02GZ1,NODE02TEMP1,NODE03GQW1,NODE03GQX1,NODE03GQY1,NODE03GQZ1,NODE03LQW1,NODE03LQX1,NODE03LQY1,NODE03LQZ1,NODE03RX1,NODE03RY1,NODE03RZ1,NODE03LX1,NODE03LY1,NODE03LZ1,NODE03AX1,NODE03AY1,NODE03AZ1,NODE03MX1,NODE03MY1,NODE03MZ1,NODE03GX1,NODE03GY1,NODE03GZ1,NODE03TEMP1,NODE04GQW1,NODE04GQX1,NODE04GQY1,NODE04GQZ1,NODE04LQW1,NODE04LQX1,NODE04LQY1,NODE04LQZ1,NODE04RX1,NODE04RY1,NODE04RZ1,NODE04LX1,NODE04LY1,NODE04LZ1,NODE04AX1,NODE04AY1,NODE04AZ1,NODE04MX1,NODE04MY1,NODE04MZ1,NODE04GX1,NODE04GY1,NODE04GZ1,NODE04TEMP1,NODE05GQW1,NODE05GQX1,NODE05GQY1,NODE05GQZ1,NODE05LQW1,NODE05LQX1,NODE05LQY1,NODE05LQZ1,NODE05RX1,NODE05RY1,NODE05RZ1,NODE05LX1,NODE05LY1,NODE05LZ1,NODE05AX1,NODE05AY1,NODE05AZ1,NODE05MX1,NODE05MY1,NODE05MZ1,NODE05GX1,NODE05GY1,NODE05GZ1,NODE05TEMP1]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [time1,Node01Gqw1,Node01Gqx1,Node01Gqy1,Node01Gqz1,Node01Lqw1,Node01Lqx1,Node01Lqy1,Node01Lqz1,Node01rx1,Node01ry1,Node01rz1,Node01lx1,Node01ly1,Node01lz1,Node01ax1,Node01ay1,Node01az1,Node01mx1,Node01my1,Node01mz1,Node01gx1,Node01gy1,Node01gz1,Node01temp1,Node02Gqw1,Node02Gqx1,Node02Gqy1,Node02Gqz1,Node02Lqw1,Node02Lqx1,Node02Lqy1,Node02Lqz1,Node02rx1,Node02ry1,Node02rz1,Node02lx1,Node02ly1,Node02lz1,Node02ax1,Node02ay1,Node02az1,Node02mx1,Node02my1,Node02mz1,Node02gx1,Node02gy1,Node02gz1,Node02temp1,Node03Gqw1,Node03Gqx1,Node03Gqy1,Node03Gqz1,Node03Lqw1,Node03Lqx1,Node03Lqy1,Node03Lqz1,Node03rx1,Node03ry1,Node03rz1,Node03lx1,Node03ly1,Node03lz1,Node03ax1,Node03ay1,Node03az1,Node03mx1,Node03my1,Node03mz1,Node03gx1,Node03gy1,Node03gz1,Node03temp1,Node04Gqw1,Node04Gqx1,Node04Gqy1,Node04Gqz1,Node04Lqw1,Node04Lqx1,Node04Lqy1,Node04Lqz1,Node04rx1,Node04ry1,Node04rz1,Node04lx1,Node04ly1,Node04lz1,Node04ax1,Node04ay1,Node04az1,Node04mx1,Node04my1,Node04mz1,Node04gx1,Node04gy1,Node04gz1,Node04temp1,Node05Gqw1,Node05Gqx1,Node05Gqy1,Node05Gqz1,Node05Lqw1,Node05Lqx1,Node05Lqy1,Node05Lqz1,Node05rx1,Node05ry1,Node05rz1,Node05lx1,Node05ly1,Node05lz1,Node05ax1,Node05ay1,Node05az1,Node05mx1,Node05my1,Node05mz1,Node05gx1,Node05gy1,Node05gz1,Node05temp1]
%   = importfile('flat4.csv',2, 59163);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/02/12 11:40:23

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
%   column25: double (%f)
%	column26: double (%f)
%   column27: double (%f)
%	column28: double (%f)
%   column29: double (%f)
%	column30: double (%f)
%   column31: double (%f)
%	column32: double (%f)
%   column33: double (%f)
%	column34: double (%f)
%   column35: double (%f)
%	column36: double (%f)
%   column37: double (%f)
%	column38: double (%f)
%   column39: double (%f)
%	column40: double (%f)
%   column41: double (%f)
%	column42: double (%f)
%   column43: double (%f)
%	column44: double (%f)
%   column45: double (%f)
%	column46: double (%f)
%   column47: double (%f)
%	column48: double (%f)
%   column49: double (%f)
%	column50: double (%f)
%   column51: double (%f)
%	column52: double (%f)
%   column53: double (%f)
%	column54: double (%f)
%   column55: double (%f)
%	column56: double (%f)
%   column57: double (%f)
%	column58: double (%f)
%   column59: double (%f)
%	column60: double (%f)
%   column61: double (%f)
%	column62: double (%f)
%   column63: double (%f)
%	column64: double (%f)
%   column65: double (%f)
%	column66: double (%f)
%   column67: double (%f)
%	column68: double (%f)
%   column69: double (%f)
%	column70: double (%f)
%   column71: double (%f)
%	column72: double (%f)
%   column73: double (%f)
%	column74: double (%f)
%   column75: double (%f)
%	column76: double (%f)
%   column77: double (%f)
%	column78: double (%f)
%   column79: double (%f)
%	column80: double (%f)
%   column81: double (%f)
%	column82: double (%f)
%   column83: double (%f)
%	column84: double (%f)
%   column85: double (%f)
%	column86: double (%f)
%   column87: double (%f)
%	column88: double (%f)
%   column89: double (%f)
%	column90: double (%f)
%   column91: double (%f)
%	column92: double (%f)
%   column93: double (%f)
%	column94: double (%f)
%   column95: double (%f)
%	column96: double (%f)
%   column97: double (%f)
%	column98: double (%f)
%   column99: double (%f)
%	column100: double (%f)
%   column101: double (%f)
%	column102: double (%f)
%   column103: double (%f)
%	column104: double (%f)
%   column105: double (%f)
%	column106: double (%f)
%   column107: double (%f)
%	column108: double (%f)
%   column109: double (%f)
%	column110: double (%f)
%   column111: double (%f)
%	column112: double (%f)
%   column113: double (%f)
%	column114: double (%f)
%   column115: double (%f)
%	column116: double (%f)
%   column117: double (%f)
%	column118: double (%f)
%   column119: double (%f)
%	column120: double (%f)
%   column121: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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
time1 = dataArray{:, 1};
Node01Gqw1 = dataArray{:, 2};
Node01Gqx1 = dataArray{:, 3};
Node01Gqy1 = dataArray{:, 4};
Node01Gqz1 = dataArray{:, 5};
Node01Lqw1 = dataArray{:, 6};
Node01Lqx1 = dataArray{:, 7};
Node01Lqy1 = dataArray{:, 8};
Node01Lqz1 = dataArray{:, 9};
Node01rx1 = dataArray{:, 10};
Node01ry1 = dataArray{:, 11};
Node01rz1 = dataArray{:, 12};
Node01lx1 = dataArray{:, 13};
Node01ly1 = dataArray{:, 14};
Node01lz1 = dataArray{:, 15};
Node01ax1 = dataArray{:, 16};
Node01ay1 = dataArray{:, 17};
Node01az1 = dataArray{:, 18};
Node01mx1 = dataArray{:, 19};
Node01my1 = dataArray{:, 20};
Node01mz1 = dataArray{:, 21};
Node01gx1 = dataArray{:, 22};
Node01gy1 = dataArray{:, 23};
Node01gz1 = dataArray{:, 24};
Node01temp1 = dataArray{:, 25};
Node02Gqw1 = dataArray{:, 26};
Node02Gqx1 = dataArray{:, 27};
Node02Gqy1 = dataArray{:, 28};
Node02Gqz1 = dataArray{:, 29};
Node02Lqw1 = dataArray{:, 30};
Node02Lqx1 = dataArray{:, 31};
Node02Lqy1 = dataArray{:, 32};
Node02Lqz1 = dataArray{:, 33};
Node02rx1 = dataArray{:, 34};
Node02ry1 = dataArray{:, 35};
Node02rz1 = dataArray{:, 36};
Node02lx1 = dataArray{:, 37};
Node02ly1 = dataArray{:, 38};
Node02lz1 = dataArray{:, 39};
Node02ax1 = dataArray{:, 40};
Node02ay1 = dataArray{:, 41};
Node02az1 = dataArray{:, 42};
Node02mx1 = dataArray{:, 43};
Node02my1 = dataArray{:, 44};
Node02mz1 = dataArray{:, 45};
Node02gx1 = dataArray{:, 46};
Node02gy1 = dataArray{:, 47};
Node02gz1 = dataArray{:, 48};
Node02temp1 = dataArray{:, 49};
Node03Gqw1 = dataArray{:, 50};
Node03Gqx1 = dataArray{:, 51};
Node03Gqy1 = dataArray{:, 52};
Node03Gqz1 = dataArray{:, 53};
Node03Lqw1 = dataArray{:, 54};
Node03Lqx1 = dataArray{:, 55};
Node03Lqy1 = dataArray{:, 56};
Node03Lqz1 = dataArray{:, 57};
Node03rx1 = dataArray{:, 58};
Node03ry1 = dataArray{:, 59};
Node03rz1 = dataArray{:, 60};
Node03lx1 = dataArray{:, 61};
Node03ly1 = dataArray{:, 62};
Node03lz1 = dataArray{:, 63};
Node03ax1 = dataArray{:, 64};
Node03ay1 = dataArray{:, 65};
Node03az1 = dataArray{:, 66};
Node03mx1 = dataArray{:, 67};
Node03my1 = dataArray{:, 68};
Node03mz1 = dataArray{:, 69};
Node03gx1 = dataArray{:, 70};
Node03gy1 = dataArray{:, 71};
Node03gz1 = dataArray{:, 72};
Node03temp1 = dataArray{:, 73};
Node04Gqw1 = dataArray{:, 74};
Node04Gqx1 = dataArray{:, 75};
Node04Gqy1 = dataArray{:, 76};
Node04Gqz1 = dataArray{:, 77};
Node04Lqw1 = dataArray{:, 78};
Node04Lqx1 = dataArray{:, 79};
Node04Lqy1 = dataArray{:, 80};
Node04Lqz1 = dataArray{:, 81};
Node04rx1 = dataArray{:, 82};
Node04ry1 = dataArray{:, 83};
Node04rz1 = dataArray{:, 84};
Node04lx1 = dataArray{:, 85};
Node04ly1 = dataArray{:, 86};
Node04lz1 = dataArray{:, 87};
Node04ax1 = dataArray{:, 88};
Node04ay1 = dataArray{:, 89};
Node04az1 = dataArray{:, 90};
Node04mx1 = dataArray{:, 91};
Node04my1 = dataArray{:, 92};
Node04mz1 = dataArray{:, 93};
Node04gx1 = dataArray{:, 94};
Node04gy1 = dataArray{:, 95};
Node04gz1 = dataArray{:, 96};
Node04temp1 = dataArray{:, 97};
Node05Gqw1 = dataArray{:, 98};
Node05Gqx1 = dataArray{:, 99};
Node05Gqy1 = dataArray{:, 100};
Node05Gqz1 = dataArray{:, 101};
Node05Lqw1 = dataArray{:, 102};
Node05Lqx1 = dataArray{:, 103};
Node05Lqy1 = dataArray{:, 104};
Node05Lqz1 = dataArray{:, 105};
Node05rx1 = dataArray{:, 106};
Node05ry1 = dataArray{:, 107};
Node05rz1 = dataArray{:, 108};
Node05lx1 = dataArray{:, 109};
Node05ly1 = dataArray{:, 110};
Node05lz1 = dataArray{:, 111};
Node05ax1 = dataArray{:, 112};
Node05ay1 = dataArray{:, 113};
Node05az1 = dataArray{:, 114};
Node05mx1 = dataArray{:, 115};
Node05my1 = dataArray{:, 116};
Node05mz1 = dataArray{:, 117};
Node05gx1 = dataArray{:, 118};
Node05gy1 = dataArray{:, 119};
Node05gz1 = dataArray{:, 120};
Node05temp1 = dataArray{:, 121};

