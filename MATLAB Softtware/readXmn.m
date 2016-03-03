function data = readXmn(x,n)
% reads n lines of data from x MotionNodes
% Note: check configuration status in Motion user interface. If nodes
% have been unplugged, select Node>Erase then Node>Scan to update config
% Wifi Bus security key: 2062012708

t = tcpip('127.0.0.1',32078);
t.ByteOrder = 'littleEndian';
% fopen(t);
% [header,~,msg] = fread(t,500,'char');
% temp = find(header==10);
% header_size = temp(length(temp))
% fclose(t);

header_size = 434; % for 8 nodes use header size 434; 6 nodes = 364
msg = [];

if isempty(msg)
    fopen(t);
    fread(t,header_size,'char');
    data = zeros(n,10*x);    
    for i = 1:n
        fread(t,2,'char');
        msize = fread(t,2,'char');
        msize = 256*msize(1) + msize(2);
        if msize ~= x*40
            warning('Warning: number of sensors does not match output');
            warning(['x = ' num2str(x) ' output size (= 40*x): ' ...
                num2str(msize)]);
            return
        end
        for j = 1:x
            id = fread(t,1,'char');
            fread(t,3,'char');
            d = fread(t,9,'single');
            data(i,10*j-9:10*j) = [id d'];
        end
    end
    fclose(t);
else
    warning(['Unsuccessful read: ' msg]);
end