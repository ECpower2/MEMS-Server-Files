function [p1,p2,p3,rsq] = beam_data_Sept(filename)
% finds coefficients for beam shape polynomial

n_nodes = 6;
sensor_loc = [0 .029 .209 .389 .569 .749];

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
[f,gof] = fit(sensor_loc', A,'poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
rsq = gof.rsquare;

% dlmwrite('tempSept.csv',[EqKmy' EqKmx' EqKmz'],'-append')