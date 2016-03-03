function data = readXmnWIFI(x,n)
% reads n lines of data from x wireless MotionNodes
% Note: check configuration status in Motion user interface

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
t.InputBufferSize = 1024;
fopen(t);
header_size = 180 + 30*x;
[~,~,msg] = fread(t,header_size,'char');

data = zeros(n,10*x);

if isempty(msg)
    for i = 1:n
        fread(t,3,'char');
        msize = fread(t,1,'char');
        if msize ~= x*40
            warning('Warning: number of sensors does not match output');
        end
        for j = 1:x
            id = fread(t,1,'char');
            fread(t,3,'char');
            d = fread(t,9,'single');
            data(i,10*j-9:10*j) = [id d'];
        end
    end
else
    warning(['Unsuccessful read: ' msg]);
end
fclose(t);