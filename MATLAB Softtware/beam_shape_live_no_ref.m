function [p1,p2,p3,rsq] = beam_shape_live_no_ref(filename,rstart,rend)
% finds coefficients for beam shape polynomial

nnodes = 8;
sensor_loc = [0 .025 .207 .388 .388 .569 .749 .749];

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

refdata = csvread([filename '-ref.csv'],1,1);
Ex_ref = mean(refdata(rstart:rend,1));

A = tan(EqKmx - Ex_ref);
[f,gof] = fit(sensor_loc', A,'poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
rsq = gof.rsquare;

figure;
plot(f,sensor_loc,A)