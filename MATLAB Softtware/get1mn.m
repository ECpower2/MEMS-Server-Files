function [data,key] = get1mn(n)
% reads n lines of data from one MotionNode

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
fopen(t);
header = char(fread(t,176,'char'))';
[~,endIDs] = regexp(header,'node id="');
[startKeys,endKeys] = regexp(header,'" key="');
key = cell(length(endIDs),2);
for i = 1:length(endIDs)
    key{i,1} = str2num(header(endKeys(i)+1));
    key{i,2} = header(endIDs(i)+1:startKeys(i)-1);
end

data = zeros(n,10);

for i = 1:n
    fread(t,3,'char');
    msize = fread(t,1,'char');
    id = fread(t,1,'char');
    fread(t,3,'char');
    data(i,:) = [id fread(t,9,'single')'];
end
fclose(t);