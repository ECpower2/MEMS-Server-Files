function beam2comsol(filename,rs,rf,n_to_avg,spacing)

if nargin < 4
    spacing = 100;
end
if nargin < 3
    n_to_avg = 99;
end

n = floor((rf-rs)/spacing);
re = rs + n_to_avg;
p1 = zeros(1,n); p2 = p1; p3 = p1; i = 1;
plist = cell(3,1);
while re < rf
    [p1(i),p2(i),p3(i),~] = beam_shape_live(filename,rs,re);
    if i==1
        plist{1} = strcat(plist{1},num2str(p1(i)),'[m^-2]');
        plist{2} = strcat(plist{2},num2str(p2(i)),'[1/m]');
        plist{3} = strcat(plist{3},num2str(p3(i)));
    else
        plist{1} = strcat(plist{1},',',num2str(p1(i)),'[m^-2]');
        plist{2} = strcat(plist{2},',',num2str(p2(i)),'[1/m]');
        plist{3} = strcat(plist{3},',',num2str(p3(i)));

    end
    i = i+1;
    rs = re + spacing - n_to_avg;
    re = re + spacing;
end

x = linspace(0,.795);
beams = zeros(100,n);
for i = 1:n
beams(:,i) = p1(i)*x.^3/3+p2(i)*x.^2/2+p3(i)*x;
end
figure;
plot(x,beams)

outfile = strcat(filename,'-p-values.txt');
fid = fopen(outfile,'w');
formatSpec = '%s %s\r\n';
fprintf(fid,formatSpec,'a1', plist{1});
fprintf(fid,formatSpec,'b1', plist{2});
fprintf(fid,formatSpec,'c1', plist{3});
fclose(fid);