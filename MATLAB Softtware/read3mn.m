function data = read3mn(n)
% reads n lines of data from three MotionNodes

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
t.InputBufferSize = 1024;
fopen(t);
[~,~,msg] = fread(t,246,'char');

data = zeros(n,30);

if isempty(msg)
    for i = 1:n
        fread(t,3,'char');
        msize = fread(t,1,'char');
        id1 = fread(t,1,'char');
        fread(t,3,'char');
        d1 = fread(t,9,'single');
        id2 = fread(t,1,'char');
        fread(t,3,'char');
        d2 = fread(t,9,'single');
        id3 = fread(t,1,'char');
        fread(t,3,'char');
        d3 = fread(t,9,'single');
        data(i,:) = [id1 d1' id2 d2' id3 d3'];
    end
else
    warning(['Unsuccessful read: ' msg]);
end
fclose(t);