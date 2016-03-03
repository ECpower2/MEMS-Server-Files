function [f,gof] = blade_shape_live(filename,reffile,rstart,rend)
% finds coefficients for blade surface shape as a polynomial that is cubic
% in x and linear in y

nnodes = 8; % number of MotionNodes
sensor_loc_x = [.085 .142 .232 .336 .392 .448 .575 .633];
% sensor_loc_y = [0 1 1 1 1 1 1 1]*-.023;
% width coordinate for blade edge in +dir:
edge_r = [.11 .096 .08 .065 .058 .053 .043 .04];
% width coordinate for blade edge in -dir:
edge_l = [-.065 -.058 -.048 -.039 -.036 -.033 -.026 -.024]; 
EqKmx = zeros(nnodes,1);  EqKmy = EqKmx;  EqKmz = EqKmx;
rEx = EqKmx; rEy = rEx; rEz = rEx;
qw = EqKmx;  qx = qw;  qy = qw;  qz = qw; j = 1; jr = 1;

for i = 1:nnodes+1
    nfile = [filename '-node' num2str(i) '.csv'];
    if exist(nfile,'file')
        data = csvread(nfile,1,1);
        EqKmx(j) = mean(data(rstart:rend,1));
        EqKmy(j) = mean(data(rstart:rend,2));
        EqKmz(j) = mean(data(rstart:rend,3));
        qw(j) = mean(data(rstart:rend,19));
        qx(j) = mean(data(rstart:rend,20));
        qy(j) = mean(data(rstart:rend,21));
        qz(j) = mean(data(rstart:rend,22));
        j = j+1;
%     else
%         warning('Missing node(s). Node IDs are not sequential.');
    end
    rfile = [reffile '-node' num2str(i) '.csv'];
    if exist(rfile,'file')
        refdata = csvread(rfile,1,1);
        rEx(jr) = mean(refdata(rstart:rend,1));
        rEy(jr) = mean(refdata(rstart:rend,2));
        rEz(jr) = mean(refdata(rstart:rend,3));
        jr = jr+1;
    end
end

% display(EqKmy)
% display(rEy)
A = tan(rEy-EqKmy);
f = fit(sensor_loc_x', A,'poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
% rsq = gof.rsquare;

figure;
plot(f,sensor_loc_x,A)

% display(EqKmx)
% display(rEx)
B = tan(rEx-EqKmx)';
y = [edge_l; edge_r];
figure;
plot(y,[B.*edge_l; B.*edge_r])

z_center = p1*sensor_loc_x.^3/3+p2*sensor_loc_x.^2/2+p3*sensor_loc_x;
z_left = z_center + (edge_l+.023)*B';
z_right = z_center + (edge_r+.023)*B';
% figure;
% plot(x,z_center,x,z_left,x,z_right)
% [gridx,gridy] = meshgrid(sensor_loc_x,[edge_l 0 edge_r]);
gridx = [sensor_loc_x; sensor_loc_x; sensor_loc_x];
gridy = [edge_l; zeros(1,8)-.023; edge_r];
[f,gof] = fit([reshape(gridx',24,1) reshape(gridy',24,1)],...
    [z_left';z_center';z_right'],'poly32');

% figure;
% plot(x,d_right)

figure;
plot(f,[reshape(gridx',24,1) reshape(gridy',24,1)],...
    [z_left';z_center';z_right'])
end