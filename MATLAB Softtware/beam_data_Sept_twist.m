function [Cfit,Lfit,Rfit,rsq] = beam_data_Sept_twist(filename)
% finds coefficients for beam shape polynomials on left (-y) and right (+y)
% edges of beam
% uses roll angle with linear estimate for twist

n_nodes = 6;
sensor_loc = [0; .029; .209; .389; .569; .749];
hw = .03;   % half-width of beam

postfile = mems_Kalman_postprocess(filename,0);
rootname = postfile(1:length(postfile)-18);
postname = '-post-process.csv';

EqKmx = zeros(n_nodes,1);  EqKmy = EqKmx;  EqKmz = EqKmx;
qw = EqKmx;  qx = qw;  qy = qw;  qz = qw;

for i = 1:n_nodes
    nfile = [rootname num2str(i-1) postname];
    if exist(nfile,'file')
        data = csvread(nfile,1,1);
        [rows,~] = size(data);
        EqKmx(i) = mean(data(200:rows,1));
        EqKmy(i) = mean(data(200:rows,2));
        EqKmz(i) = mean(data(200:rows,3));
        qw(i) = mean(data(200:rows,19));
        qx(i) = mean(data(200:rows,20));
        qy(i) = mean(data(200:rows,21));
        qz(i) = mean(data(200:rows,22));
    else
        warning('Missing node(s). Node IDs are not sequential.');
    end
end

A = tan(EqKmy);
[f,gof] = fit(sensor_loc, A,'poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
rsq = gof.rsquare;
Cfit = [p1/3 p2/2 p3];

beam_c = p1*sensor_loc.^3/3 + p2*sensor_loc.^2/2 + p3*sensor_loc;
beam_l = beam_c - hw*tan(EqKmx);
beam_r = beam_c + hw*tan(EqKmx);
beam_l(1) = 0;
beam_r(1) = 0;

p = polyfitZero(sensor_loc, beam_l,3);
p1 = p(1); p2 = p(2); p3 = p(3);
% rsqL = gof.rsquare;
Lfit = [p1 p2 p3];

p = polyfitZero(sensor_loc, beam_r,3);
p1 = p(1); p2 = p(2); p3 = p(3);
% rsqR = gof.rsquare;
Rfit = [p1 p2 p3];

% rsq = [rsqC rsqL rsqR];