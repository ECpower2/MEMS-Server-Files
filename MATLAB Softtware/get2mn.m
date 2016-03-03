function [data,key] = get2mn(n)
% reads n lines of data from two MotionNodes

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
t.InputBufferSize = 1024;
fopen(t);
header = char(fread(t,211,'char'))';
[~,endIDs] = regexp(header,'node id="');
[startKeys,endKeys] = regexp(header,'" key="');
key = cell(length(endIDs),2);
for i = 1:length(endIDs)
    key{i,1} = str2num(header(endKeys(i)+1));
    key{i,2} = header(endIDs(i)+1:startKeys(i)-1);
end

data = zeros(n,20);

for i = 1:n
    fread(t,3,'char');
    msize = fread(t,1,'char');
    id1 = fread(t,1,'char');
    fread(t,3,'char');
    d1 = fread(t,9,'single');
    id2 = fread(t,1,'char');
    fread(t,3,'char');
    d2 = fread(t,9,'single');
    data(i,:) = [id1 d1' id2 d2'];
end
fclose(t);