function [p1,p2,p3,rsq] = beam_data_avgSept(disp)
% finds average value of Kalman filtered parameters

n_nodes = 6;
reps = 4;

EqKmx = zeros(reps,n_nodes);  EqKmy = EqKmx;  EqKmz = EqKmx;
qw = EqKmx;  qx = EqKmx;  qy = EqKmx;  qz = EqKmx;

for i = 1:n_nodes
    for j = 1:reps
        file = ['beam' num2str(disp) 'mm' num2str(j) '-node'...
            num2str(i-1) '-post-process.csv'];
%         file = ['beam_rezero' num2str(j) '-node'...
%                 num2str(i-1) '-complete-post-process.csv'];
        if exist(file,'file')
            data = csvread(file,1,1);
            [rows,~] = size(data);
            EqKmx(j,i) = mean(data(200:rows,1));
            EqKmy(j,i) = mean(data(200:rows,2));
            EqKmz(j,i) = mean(data(200:rows,3));
            qw(j,i) = mean(data(200:rows,19));
            qx(j,i) = mean(data(200:rows,20));
            qy(j,i) = mean(data(200:rows,21));
            qz(j,i) = mean(data(200:rows,22));
        end
    end
end

% rx = mean(EqKmx,1);
ry = mean(EqKmy,1);
if EqKmy(2,1) == 0; 
    ry = (EqKmy(1,:) + EqKmy(3,:) + EqKmy(4,:))/3;
end
% rz = mean(EqKmz,1);

A = tan(ry);
sensor_loc = [0 .029 .209 .389 .569 .749];
[f,gof] = fit(sensor_loc', A','poly2');
p1 = f.p1; p2 = f.p2; p3 = f.p3;
rsq = gof.rsquare;
