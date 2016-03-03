function [W,X,Y,Z] = get_mn_avgs(filename)
% processes MotionNode take files for beam_shape.m

data = dlmread(filename,',',1,0);

% w1 = mean(data(:,2));
% x1 = mean(data(:,3));
% y1 = mean(data(:,4));
% z1 = mean(data(:,5));
% w2 = mean(data(:,27));
% x2 = mean(data(:,28));
% y2 = mean(data(:,29));
% z2 = mean(data(:,30));
% w3 = mean(data(:,52));
% x3 = mean(data(:,53));
% y3 = mean(data(:,54));
% z3 = mean(data(:,55));
% w4 = mean(data(:,77));
% x4 = mean(data(:,78));
% y4 = mean(data(:,79));
% z4 = mean(data(:,80));
% w5 = mean(data(:,102));
% x5 = mean(data(:,103));
% y5 = mean(data(:,104));
% z5 = mean(data(:,105));
% w0 = mean(data(:,127));
% x0 = mean(data(:,128));
% y0 = mean(data(:,129));
% z0 = mean(data(:,130));
w0 = mean(data(:,2));
x0 = mean(data(:,3));
y0 = mean(data(:,4));
z0 = mean(data(:,5));
w1 = mean(data(:,27));
x1 = mean(data(:,28));
y1 = mean(data(:,29));
z1 = mean(data(:,30));
w2 = mean(data(:,52));
x2 = mean(data(:,53));
y2 = mean(data(:,54));
z2 = mean(data(:,55));
w3 = mean(data(:,77));
x3 = mean(data(:,78));
y3 = mean(data(:,79));
z3 = mean(data(:,80));
w4 = mean(data(:,102));
x4 = mean(data(:,103));
y4 = mean(data(:,104));
z4 = mean(data(:,105));
w5 = mean(data(:,127));
x5 = mean(data(:,128));
y5 = mean(data(:,129));
z5 = mean(data(:,130));

q2 = q_quot([w2 x2 y2 z2],[w0 x0 y0 z0]);
q3 = q_quot([w3 x3 y3 z3],[w0 x0 y0 z0]);
q4 = q_quot([w4 x4 y4 z4],[w0 x0 y0 z0]);
q5 = q_quot([w5 x5 y5 z5],[w0 x0 y0 z0]);

W = [w0 q2(1) q3(1) q4(1) q5(1)];
X = [x0 q2(2) q3(2) q4(2) q5(2)];
Y = [y0 q2(3) q3(3) q4(3) q5(3)];
Z = [z0 q2(4) q3(4) q4(4) q5(4)];

% W = [w0 w2 w3 w4 w5];
% X = [x0 x2 x3 x4 x5];
% Y = [y0 y2 y3 y4 y5];
% Z = [z0 z2 z3 z4 z5];