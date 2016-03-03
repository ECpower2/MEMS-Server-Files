function [f,gof] = beam_shape_live_torsion(filename,rstart,rend)
% finds coefficients for beam surface shape as a polynomial that is cubic
% in x and quadratic in y

nnodes = 8; % number of MotionNodes
% npairs = 2; % number of pairs (nodes at same x coordinate)
sensor_loc_x = [0 .025 .207 .388 .388 .569 .749 .749];
sensor_loc_y = [0 0 0 .018 -.018 0 .018 -.018];
hw = 0.03; % beam half width

EqKmx = zeros(nnodes,1);  EqKmy = EqKmx;  EqKmz = EqKmx;
qw = EqKmx;  qx = qw;  qy = qw;  qz = qw; j = 1;

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
end

A = -tan(EqKmx);
f = fit(sensor_loc_x', A,'poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
% rsq = gof.rsquare;

figure;
plot(f,sensor_loc_x,A)

B = tan(EqKmy);
m = [0 0]; b = m;
m(1) = (B(4) - B(5))/(sensor_loc_y(4) - sensor_loc_y(5));
m(2) = (B(7) - B(8))/(sensor_loc_y(7) - sensor_loc_y(8));
b(1) = B(4) - m(1)*sensor_loc_y(4);
b(2) = B(7) - m(2)*sensor_loc_y(7);
% m = zeros(npairs,1); b = m;
% for i = 1:npairs
%     for j = i:nnodes-1
%         if sensor_loc_x(j)==sensor_loc_x(j+1)
%             m(i) = (B(j) - B(j+1))/(sensor_loc_y(j)-sensor_loc_y(j+1));
%             b(i) = B(j) - m(i)*sensor_loc_y(j);
%         end
%     end
% end

y = linspace(-hw,hw);
figure;
plot(y,0*y,y,B(2)*y,y,B(3)*y,y,.5*m(1)*y.^2+b(1)*y,y,B(6)*y,...
    y,.5*m(2)*y.^2+b(2)*y)
legend('0','1','2','3/4','5','6/7')

x = [0 sensor_loc_x(3:4) sensor_loc_x(6:7)];
d_left = [0 -hw*B(3) .5*m(1)*hw^2-b(1)*hw -hw*B(6) .5*m(2)*hw^2-b(2)*hw];
d_right = [0 hw*B(3) .5*m(1)*hw^2+b(1)*hw hw*B(6) .5*m(2)*hw^2+b(2)*hw];
z_center = p1*x.^3/3+p2*x.^2/2+p3*x;
z_left = z_center + d_left;
z_right = z_center + d_right;
% figure;
% plot(x,z_center,x,z_left,x,z_right)
[gridx,gridy] = meshgrid(x,[-hw 0 hw]);
[f,gof] = fit([reshape(gridx',15,1) reshape(gridy',15,1)],...
    [z_left';z_center';z_right'],'poly32');

% figure;
% plot(x,d_right)

figure;
plot(f,[reshape(gridx',15,1) reshape(gridy',15,1)],...
    [z_left';z_center';z_right'])
end