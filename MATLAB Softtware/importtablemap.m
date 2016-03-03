function [time,Qw1,Qx1,Qy1,Qz1,Gqw1,Gqx1,Gqy1,Gqz1,Lqw1,Lqx1,Lqy1,Lqz1,rx1,ry1,rz1,lx1,ly1,lz1,ax1,ay1,az1,mx1,my1,mz1,gx1,gy1,gz1,Qw2,Qx2,Qy2,Qz2,Gzw2,Gqx2,Gqy2,Gqz2,Lqw2,Lqx2,Lqy2,Lqz2,rx2,ry2,rz2,lx2,ly2,lz2,ax2,ay2,az2,mx2,my2,mz2,gx2,gy2,gz2,Qw3,Qx3,Qy3,Qz3,Gqw3,Gqx3,Gqy3,Gqz3,Lqw3,Lqx3,Lqy3,Lqz3,rx3,ry3,rz3,lx3,ly3,lz3,ax3,ay3,az3,mx3,my3,mz3,gx3,gy3,gz3,Qw4,Qx4,Qy4,Qz4,Gqw4,Gqx4,Gqy4,Gqz4,Lqw4,Lqx4,Lqy4,Lqz4,rx4,ry4,rz4,lx4,ly4,lz4,ax4,ay4,az4,mx4,my4,mz4,gx4,gy4,gz4,Qw5,Qx5,Qy5,Qz5,Gqw5,Gqx5,Gqy5,Gqz5,Lqw5,Lqx5,Lqy5,Lqz5,rx5,ry5,rz5,lx5,ly5,lz5,ax5,ay5,az5,mx5,my5,mz5,gx5,gy5,gz5] = importtablemap(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [VARNAME1,VARNAME2,VARNAME3,VARNAME4,VARNAME5,VARNAME6,VARNAME7,VARNAME8,VARNAME9,VARNAME10,VARNAME11,VARNAME12,VARNAME13,VARNAME14,VARNAME15,VARNAME16,VARNAME17,VARNAME18,VARNAME19,VARNAME20,VARNAME21,VARNAME22,VARNAME23,VARNAME24,VARNAME25,VARNAME26,VARNAME27,VARNAME28,temp1,VARNAME30,VARNAME31,VARNAME32,VARNAME33,VARNAME34,VARNAME35,VARNAME36,VARNAME37,VARNAME38,VARNAME39,VARNAME40,VARNAME41,VARNAME42,VARNAME43,VARNAME44,VARNAME45,VARNAME46,VARNAME47,VARNAME48,VARNAME49,VARNAME50,VARNAME51,VARNAME52,VARNAME53,VARNAME54,VARNAME55,VARNAME56,VARNAME57,VARNAME58,VARNAME59,VARNAME60,VARNAME61,VARNAME62,VARNAME63,VARNAME64,VARNAME65,VARNAME66,VARNAME67,VARNAME68,VARNAME69,VARNAME70,VARNAME71,VARNAME72,VARNAME73,VARNAME74,VARNAME75,VARNAME76,VARNAME77,VARNAME78,VARNAME79,VARNAME80,VARNAME81,VARNAME82,VARNAME83,VARNAME84,VARNAME85,VARNAME86,VARNAME87,VARNAME88,VARNAME89,VARNAME90,VARNAME91,VARNAME92,VARNAME93,VARNAME94,VARNAME95,VARNAME96,VARNAME97,VARNAME98,VARNAME99,VARNAME100,VARNAME101,VARNAME102,VARNAME103,VARNAME104,VARNAME105,VARNAME106,VARNAME107,VARNAME108,VARNAME109,VARNAME110,VARNAME111,VARNAME112,VARNAME113,VARNAME114,VARNAME115,VARNAME116,VARNAME117,VARNAME118,VARNAME119,VARNAME120,VARNAME121,VARNAME122,VARNAME123,VARNAME124,VARNAME125,VARNAME126,VARNAME127,VARNAME128,VARNAME129,VARNAME130,VARNAME131,VARNAME132,VARNAME133,VARNAME134,VARNAME135,VARNAME136]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [VARNAME1,VARNAME2,VARNAME3,VARNAME4,VARNAME5,VARNAME6,VARNAME7,VARNAME8,VARNAME9,VARNAME10,VARNAME11,VARNAME12,VARNAME13,VARNAME14,VARNAME15,VARNAME16,VARNAME17,VARNAME18,VARNAME19,VARNAME20,VARNAME21,VARNAME22,VARNAME23,VARNAME24,VARNAME25,VARNAME26,VARNAME27,VARNAME28,temp1,VARNAME30,VARNAME31,VARNAME32,VARNAME33,VARNAME34,VARNAME35,VARNAME36,VARNAME37,VARNAME38,VARNAME39,VARNAME40,VARNAME41,VARNAME42,VARNAME43,VARNAME44,VARNAME45,VARNAME46,VARNAME47,VARNAME48,VARNAME49,VARNAME50,VARNAME51,VARNAME52,VARNAME53,VARNAME54,VARNAME55,VARNAME56,VARNAME57,VARNAME58,VARNAME59,VARNAME60,VARNAME61,VARNAME62,VARNAME63,VARNAME64,VARNAME65,VARNAME66,VARNAME67,VARNAME68,VARNAME69,VARNAME70,VARNAME71,VARNAME72,VARNAME73,VARNAME74,VARNAME75,VARNAME76,VARNAME77,VARNAME78,VARNAME79,VARNAME80,VARNAME81,VARNAME82,VARNAME83,VARNAME84,VARNAME85,VARNAME86,VARNAME87,VARNAME88,VARNAME89,VARNAME90,VARNAME91,VARNAME92,VARNAME93,VARNAME94,VARNAME95,VARNAME96,VARNAME97,VARNAME98,VARNAME99,VARNAME100,VARNAME101,VARNAME102,VARNAME103,VARNAME104,VARNAME105,VARNAME106,VARNAME107,VARNAME108,VARNAME109,VARNAME110,VARNAME111,VARNAME112,VARNAME113,VARNAME114,VARNAME115,VARNAME116,VARNAME117,VARNAME118,VARNAME119,VARNAME120,VARNAME121,VARNAME122,VARNAME123,VARNAME124,VARNAME125,VARNAME126,VARNAME127,VARNAME128,VARNAME129,VARNAME130,VARNAME131,VARNAME132,VARNAME133,VARNAME134,VARNAME135,VARNAME136]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [VarName1,VarName2,VarName3,VarName4,VarName5,VarName6,VarName7,VarName8,VarName9,VarName10,VarName11,VarName12,VarName13,VarName14,VarName15,VarName16,VarName17,VarName18,VarName19,VarName20,VarName21,VarName22,VarName23,VarName24,VarName25,VarName26,VarName27,VarName28,temp1,VarName30,VarName31,VarName32,VarName33,VarName34,VarName35,VarName36,VarName37,VarName38,VarName39,VarName40,VarName41,VarName42,VarName43,VarName44,VarName45,VarName46,VarName47,VarName48,VarName49,VarName50,VarName51,VarName52,VarName53,VarName54,VarName55,VarName56,VarName57,VarName58,VarName59,VarName60,VarName61,VarName62,VarName63,VarName64,VarName65,VarName66,VarName67,VarName68,VarName69,VarName70,VarName71,VarName72,VarName73,VarName74,VarName75,VarName76,VarName77,VarName78,VarName79,VarName80,VarName81,VarName82,VarName83,VarName84,VarName85,VarName86,VarName87,VarName88,VarName89,VarName90,VarName91,VarName92,VarName93,VarName94,VarName95,VarName96,VarName97,VarName98,VarName99,VarName100,VarName101,VarName102,VarName103,VarName104,VarName105,VarName106,VarName107,VarName108,VarName109,VarName110,VarName111,VarName112,VarName113,VarName114,VarName115,VarName116,VarName117,VarName118,VarName119,VarName120,VarName121,VarName122,VarName123,VarName124,VarName125,VarName126,VarName127,VarName128,VarName129,VarName130,VarName131,VarName132,VarName133,VarName134,VarName135,VarName136]
%   = importfile('table01z1map.csv',1, 3539);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/04/04 11:00:52

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 1;
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
%	column122: double (%f)
%   column123: double (%f)
%	column124: double (%f)
%   column125: double (%f)
%	column126: double (%f)
%   column127: double (%f)
%	column128: double (%f)
%   column129: double (%f)
%	column130: double (%f)
%   column131: double (%f)
%	column132: double (%f)
%   column133: double (%f)
%	column134: double (%f)
%   column135: double (%f)
%	column136: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

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
Qw1 = dataArray{:, 2};
Qx1 = dataArray{:, 3};
Qy1 = dataArray{:, 4};
Qz1 = dataArray{:, 5};
Gqw1 = dataArray{:, 6};
Gqx1 = dataArray{:, 7};
Gqy1 = dataArray{:, 8};
Gqz1 = dataArray{:, 9};
Lqw1 = dataArray{:, 10};
Lqx1 = dataArray{:, 11};
Lqy1 = dataArray{:, 12};
Lqz1 = dataArray{:, 13};
rx1 = dataArray{:, 14};
ry1 = dataArray{:, 15};
rz1 = dataArray{:, 16};
lx1 = dataArray{:, 17};
ly1 = dataArray{:, 18};
lz1 = dataArray{:, 19};
ax1 = dataArray{:, 20};
ay1 = dataArray{:, 21};
az1 = dataArray{:, 22};
mx1 = dataArray{:, 23};
my1 = dataArray{:, 24};
mz1 = dataArray{:, 25};
gx1 = dataArray{:, 26};
gy1 = dataArray{:, 27};
gz1 = dataArray{:, 28};
Qw2 = dataArray{:, 29};
Qx2 = dataArray{:, 30};
Qy2 = dataArray{:, 31};
Qz2 = dataArray{:, 32};
Gzw2 = dataArray{:, 33};
Gqx2 = dataArray{:, 34};
Gqy2 = dataArray{:, 35};
Gqz2 = dataArray{:, 36};
Lqw2 = dataArray{:, 37};
Lqx2 = dataArray{:, 38};
Lqy2 = dataArray{:, 39};
Lqz2 = dataArray{:, 40};
rx2 = dataArray{:, 41};
ry2 = dataArray{:, 42};
rz2 = dataArray{:, 43};
lx2 = dataArray{:, 44};
ly2 = dataArray{:, 45};
lz2 = dataArray{:, 46};
ax2 = dataArray{:, 47};
ay2 = dataArray{:, 48};
az2 = dataArray{:, 49};
mx2 = dataArray{:, 50};
my2 = dataArray{:, 51};
mz2 = dataArray{:, 52};
gx2 = dataArray{:, 53};
gy2 = dataArray{:, 54};
gz2 = dataArray{:, 55};
Qw3 = dataArray{:, 56};
Qx3 = dataArray{:, 57};
Qy3 = dataArray{:, 58};
Qz3 = dataArray{:, 59};
Gqw3 = dataArray{:, 60};
Gqx3 = dataArray{:, 61};
Gqy3 = dataArray{:, 62};
Gqz3 = dataArray{:, 63};
Lqw3 = dataArray{:, 64};
Lqx3 = dataArray{:, 65};
Lqy3 = dataArray{:, 66};
Lqz3 = dataArray{:, 67};
rx3 = dataArray{:, 68};
ry3 = dataArray{:, 69};
rz3 = dataArray{:, 70};
lx3 = dataArray{:, 71};
ly3 = dataArray{:, 72};
lz3 = dataArray{:, 73};
ax3 = dataArray{:, 74};
ay3 = dataArray{:, 75};
az3 = dataArray{:, 76};
mx3 = dataArray{:, 77};
my3 = dataArray{:, 78};
mz3 = dataArray{:, 79};
gx3 = dataArray{:, 80};
gy3 = dataArray{:, 81};
gz3 = dataArray{:, 82};
Qw4 = dataArray{:, 83};
Qx4 = dataArray{:, 84};
Qy4 = dataArray{:, 85};
Qz4 = dataArray{:, 86};
Gqw4 = dataArray{:, 87};
Gqx4 = dataArray{:, 88};
Gqy4 = dataArray{:, 89};
Gqz4 = dataArray{:, 90};
Lqw4 = dataArray{:, 91};
Lqx4 = dataArray{:, 92};
Lqy4 = dataArray{:, 93};
Lqz4 = dataArray{:, 94};
rx4 = dataArray{:, 95};
ry4 = dataArray{:, 96};
rz4 = dataArray{:, 97};
lx4 = dataArray{:, 98};
ly4 = dataArray{:, 99};
lz4 = dataArray{:, 100};
ax4 = dataArray{:, 101};
ay4 = dataArray{:, 102};
az4 = dataArray{:, 103};
mx4 = dataArray{:, 104};
my4 = dataArray{:, 105};
mz4 = dataArray{:, 106};
gx4 = dataArray{:, 107};
gy4 = dataArray{:, 108};
gz4 = dataArray{:, 109};
Qw5 = dataArray{:, 110};
Qx5 = dataArray{:, 111};
Qy5 = dataArray{:, 112};
Qz5 = dataArray{:, 113};
Gqw5 = dataArray{:, 114};
Gqx5 = dataArray{:, 115};
Gqy5 = dataArray{:, 116};
Gqz5 = dataArray{:, 117};
Lqw5 = dataArray{:, 118};
Lqx5 = dataArray{:, 119};
Lqy5 = dataArray{:, 120};
Lqz5 = dataArray{:, 121};
rx5 = dataArray{:, 122};
ry5 = dataArray{:, 123};
rz5 = dataArray{:, 124};
lx5 = dataArray{:, 125};
ly5 = dataArray{:, 126};
lz5 = dataArray{:, 127};
ax5 = dataArray{:, 128};
ay5 = dataArray{:, 129};
az5 = dataArray{:, 130};
mx5 = dataArray{:, 131};
my5 = dataArray{:, 132};
mz5 = dataArray{:, 133};
gx5 = dataArray{:, 134};
gy5 = dataArray{:, 135};
gz5 = dataArray{:, 136};

