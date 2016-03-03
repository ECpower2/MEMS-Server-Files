function d_fit = blade_fit3(sensorz)

filename = 'D:\acooperman\My Documents\WindChallenge\blade_disp_neg_v.csv';
data = dlmread(filename,',',8,0);
x = data(:,1); y = data(:,2); z = -.129 - data(:,3); v = data(:,4);
z_s = zeros(length(sensorz),1); x_s = z_s; dvdx = z_s; dvdz = z_s;
f = fit([x,z],v,'poly23');
dx = 0.001;

for i = 1:length(sensorz)
    temp_z = find(abs(z-sensorz(i))<.002);
    temp_x = find(abs(x-sensorx(i))<.002);
    temp = intersect(temp_z,temp_x);
    display(size(temp));
    z_s(i) = z(min(temp));
    x_s(i) = x(min(temp));
    dvdz(i) = (f(x_s(i),z_s(i)+dx)-f(x_s(i),z_s(i)))/dx;
    dvdx(i) = (f(x_s(i)+dx,z_s(i))-f(x_s(i),z_s(i)))/dx;
end

fz = fit(z_s,dvdz,'poly2');
fx = fit(x_s,dvdx,'linear');
[gridx,gridy] = meshgrid(x,[-hw 0 hw]);
[f,gof] = fit([reshape(gridx',15,1) reshape(gridy',15,1)],...
    [z_left';z_center';z_right'],'poly32');

blade = f.p1*(z.^3-.085^3)/3 + f.p2*(z.^2-.085^2)/2 + f.p3*(z-.085);
% blade = f.p1*z.^3/3 + f.p2*z.^2/2 + f.p3*z;
d_fit = 1 - goodnessOfFit(blade,disp,'NRMSE');