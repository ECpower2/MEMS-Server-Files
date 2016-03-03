function LUNApost(filename)

[L,x,y] = LUNAtable_lookup;
path = 'D:/acooperman/My Documents/testMay/Luna/post20May/flat_Tare/';

data = dlmread([path filename],'\t',4,1);
[rows,cols] = size(data);
fiber = data(1,:);
xfiber = zeros(size(fiber)); yfiber = xfiber;
data = data(2:rows-1,:); % remove length coordinate (1st row) and last row
% bug in LUNA output: last row is duplicate of previous row
for i=1:cols
    if fiber(i)<0.87
        xfiber(i) = fiber(i) - 0.089;
        yfiber(i) = 0.006;
    elseif fiber(i)>1.89
        xfiber(i) = fiber(i) - 1.875;
        yfiber(i) = 0.008;
    else
        xfiber(i) = interp1(L,x,fiber(i),'pchip');
        yfiber(i) = interp1(L,y,fiber(i),'pchip');
    end
end

% outpath = 'D:/acooperman/My Documents/testMay/Luna-MEMS analysis/';
outpath = 'D:/acooperman/Desktop/';
n = length(filename);
outfile = [filename(1:n-4) '.csv'];
dlmwrite([outpath outfile],[xfiber;yfiber]);

goodrows = zeros(size(data)); j = 0;
for i=1:rows-2
    plot(xfiber,data(i,:))
%     plot(fiber,data(i,:))
    if i==rows-2
        plot(xfiber,data(i,:),'r');
    end
    xlim([0 .8]);
    ylim([-200 1000]);
    omit = input('Omit this sample? (y/n) ','s');
    if isempty(omit)||omit == 'n'
        j = j+1;
        dlmwrite([outpath outfile],data(i,:),'-append');
        goodrows(j,:) = data(i,:);
    end
end

goodrows = goodrows(1:j,:);
filterdata = data;
for k=1:cols
    for i=1:j
        if goodrows(i,k)>1000||goodrows(i,k)<-200
            goodrows(i,k) = NaN;
        end
    end
    for i=1:rows-2
        if data(i,k)>1000||data(i,k)<-200
            filterdata(i,k) = NaN;
        end
    end
end
M = [zeros(size(fiber));mean(data);mean(filterdata,'omitnan');...
    mean(goodrows,'omitnan')];
dlmwrite([outpath outfile],M,'-append');

plot(xfiber,mean(filterdata),xfiber,mean(goodrows))
xlim([0 .8])