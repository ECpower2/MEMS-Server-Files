function d_fit = blade_fit_min(sensors)

filename = 'D:\acooperman\My Documents\WindChallenge\blade_neg_disp.csv';
data = dlmread(filename,',',8,0);
z = data(:,1); disp = data(:,2);
Y = diff(disp)./diff(z);
z_s = zeros(1,length(sensors)); Y_s = z_s;

for i = 1:length(sensors)
    z_s(i) = z(find(z<sensors(i),1,'last'));
    Y_s(i) = Y(find(z(1:length(Y))<sensors(i),1,'last'));
end

f = fit(z_s',Y_s','poly2');

blade = f.p1*(z.^3-.085^3)/3 + f.p2*(z.^2-.085^2)/2 + f.p3*(z-.085);
% blade = f.p1*z.^3/3 + f.p2*z.^2/2 + f.p3*z;
d_fit = 1 - goodnessOfFit(blade,disp,'NRMSE');