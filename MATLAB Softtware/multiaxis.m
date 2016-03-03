function multiaxis(outfile)
% generates axis coordinates for multiaxis rotation
% choose appropriate values for n_axes, step(1,2,3) and q(1,:)
% set axis order for each test

n_axes = 3; n = n_axes*6+1;
step = zeros(n_axes,1); k = 0;
step(1) = 15*pi/180;   % step size about first axis
step(2) = -15*pi/180;   % step size about second axis
step(3) = 15*pi/180;   % step size about third axis

x = zeros(n,3); y = x; z = x;
q = zeros(n,4);
r = zeros(n,3);

% q(1,:) = [1 0 0 0];
% q(1,:) = [cos(115*pi/360) 0 sin(115*pi/360) 0];
% q(1,:) = q_product(cos(-pi/6),0,sin(-pi/6),0,cos(pi/8),0,0,sin(pi/8));
% q(1,:) = q_product(cos(pi/2),0,sin(pi/2),0,cos(-pi/12),sin(-pi/12),0,0);
q(1,:) = q_product(cos(-pi/12),sin(-pi/12),0,0,cos(35*pi/72),0,sin(35*pi/72),0);
x(1,:) = vq(q(1,:),[1 0 0]);
y(1,:) = [0 1 0];
% z(1,:) = vq(q(1,:),[0 0 1]);
z(1,:) = [0 0 -1];
[rx,ry,rz] = q2euler(q(1,:));
r(1,:) = 180*[rx ry rz]/pi;

for i = 2:n
    j = mod(k,n_axes) + 1;
    if j==1
%         axis = y(1,:);   % select for yx
%         axis = z(i-1,:); % select for zy
        if i<4
            axis = x(1,:); else axis = x(i-1,:);  % select for xyz
        end
    elseif j==2
%         axis = x(i-1,:);  % select for yx
        axis = y(1,:);    % select for zy and xyz
%         axis = z(1,:);  % select for xz
    else
        axis = z(i-1,:);  % select for xyz
    end
    a = cos(step(j)/2);
    b = sin(step(j)/2);
    q(i,:) = q_prod([a b*axis],q(i-1,:));
    y(i,:) = [0 1 0];
    x(i,:) = vq([a b*axis],x(i-1,:));
%     z(i,:) = z(1,:);
    if j==1
        x(i,:) = x(i-1,:);
        z(i,:) = z(i-1,:);
    else
        x(i,:) = vq([a b*axis],x(i-1,:));
        z(i,:) = vq([a b*axis],z(i-1,:));
    end
%     z(i,:) = vq([a b*axis],z(i-1,:));
    [rx,ry,rz] = q2euler(q(i,:));
    r(i,:) = 180*[rx ry rz]/pi;
    k = k+1;
end

if(nargin == 1)
    header = {'qw','qx','qy','qz','x1','x2','x3','y1','y2','y3','z1',...
        'z2','z3','rx','ry','rz'};
    data = [q x y z r];
    xlswrite(outfile,header);
    xlswrite(outfile,data,1,'A2');
end