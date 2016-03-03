function [mse,nrmse,nmse] = shapecomp(DICfile,MEMSfile)
% compares shape measured using DIC with calculated beam deflection from
% MEMS MotionNode sensors

[~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~,c1,c2,gamma,X,Y,Z] = importDIC(DICfile);
X = X - min(X);
% Y = Y - min(Y);

g = 300;     % grid size for DIC and MEMS

rs = 295;
rf = 1500;
n_to_avg = 5;
spacing = 500;

xlin = linspace(0,max(X),g);
ylin = linspace(min(Y),max(Y),g);
[Xlin,Ylin] = meshgrid(xlin,ylin);
f = scatteredInterpolant(X,Y,Z);
Zlin = f(Xlin,Ylin);

n = floor((rf-rs)/spacing);
re = rs + n_to_avg;
p1 = zeros(1,n); p2 = p1; p3 = p1; id = cell(1,n); i = 1;
while re < rf
    [p1(i),p2(i),p3(i),~] = beam_shape_live(MEMSfile,rs,re);
    id{i} = num2str(re/100);
    i = i+1;
    rs = re + spacing - n_to_avg;
    re = re + spacing;
end

p1 = p1/3e6;    p2 = p2/2e3;    % change units from meters to mm

beams = zeros(g,n);
for i = 1:n
beams(:,i) = p1(i)*xlin.^3+p2(i)*xlin.^2+p3(i)*xlin;
end
beams = -beams;   % set deflection downwards

figure;
surf(Xlin,Ylin,Zlin)
shading flat
colormap jet
hold on
plot3(xlin,zeros(g,1),beams(:,n),'k')

figure;
plot(xlin,beams)
hold on
plot(xlin,Zlin(g/2,:))

mse = goodnessOfFit(beams(:,n),Zlin(g/2,:)','MSE');
nrmse = goodnessOfFit(beams(:,n),Zlin(g/2,:)','NRMSE');
nmse = goodnessOfFit(beams(:,n),Zlin(g/2,:)','NMSE');