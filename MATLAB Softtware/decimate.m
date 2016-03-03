function decimate(filename)
% creates new xls file with 1/10 as many datapoints, saves as filename_10

file = [filename '.csv'];
newfile = [filename '_10.xls'];

d = importdata(file,',',1);
[r,c] = size(d.data);
newdata = zeros(ceil(r/10),c);
n = 1;

for i = 1:r
    j = mod(i,10);
    if j==1
        newdata(n,:) = d.data(i,:);
        n = n+1;
    end
end

xlswrite(newfile,d.colheaders);
xlswrite(newfile,newdata,1,'A2');