function data = read1mn(n)
% reads n lines of data from one MotionNode

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
fopen(t);
[~,~,msg] = fread(t,176,'char');

data = zeros(n,9);

if isempty(msg)
    for i = 1:n
        fread(t,3,'char');
        msize = fread(t,1,'char');
        id = fread(t,1,'char');
        fread(t,3,'char');
        data(i,:) = fread(t,9,'single')';
    end
else
    warning(['Unsuccessful read: ' msg]);
end
fclose(t);