function shape = beam_shape(W,X,Y,Z,node_config)
% Outputs 2nd order fit for beam deflection shape based on global
% quaternion output of MotionNodes. 
% Indices (0), (1), ... (n) denote nodes where (0) is the reference node 
% W = [Gqw(0) Gqw(1) ... Gqw(n)] 
% X = [Gqx(0) Gqx(1) ... Gqx(n)]
% Y = [Gqy(0) Gqy(1) ... Gqy(n)]
% Z = [Gqz(0) Gqz(1) ... Gqz(n)]
% node_config = [x(0) y(0) z(0); x(1) y(1) z(1); ... x(n) y(n) z(n)]
% Local coordinate system for node_config:
% x = edgewise (in plane)
% y = flapwise (out of plane)
% z = beam axis

% c = 1; % c = EI for Euler-Bernoulli beam
% L = 1; % L = beam length
n = length(W)-1;
Q = zeros(n,4);
s = zeros(n,1); % P = zeros(n,1); v = zeros(n,1);
% nz = node_config(2:n+1,3);

% Find orientation of measurement nodes relative to (0)
for i = 2:n+1
    Q(i-1,:) = q_quotient(W(i),X(i),Y(i),Z(i),W(1),X(1),Y(1),Z(1));
end

% ??? extra step to correct for initial misalignment between reference and
% measurement nodes ???

% Fit to Euler-Bernoulli beam equation: 
% v = (P/(6EI))*(2L^3 - 3L^2 x + x^3)
% v' = (P/(2EI))*(-L^2 + x^2)
% for i = 1:n
%     s(i) = tan(2*acos(Q(i,1)));
%     P(i) = 2*c*s(i)/(nz(i)^2 - L^2);
%     v(i) = P(i)*(2*L^3 - 3*L^2*nz(i) + nz(i)^3)/(6*c);
% end

% Fit to quadratic curve
% s1 = tan(2*acos(Q(1,1)));
% s2 = tan(2*acos(Q(2,1)));
% a = .5*(s2-s1)/(node_config(3,3)-node_config(2,3));
% b = s1 - (s2-s1)*node_config(2,3)/(node_config(3,3)-node_config(2,3));

% Plot beam shape
% Z = linspace(0,1);
% figure;
% plot(Z,a*Z.^2+b*Z)
% hold on
% plot([0 nz(1) nz(2)],[0 a*nz(1)^2+b*nz(1) a*nz(2)^2+b*nz(2)],'o')

% Plot beam shape
% p = mean(P);
% bx = linspace(0,1);
% figure;
% plot(bx,p*(2*L^3 - 3*L^2*bx + bx.^3)/(6*c),'-k',nz,v,'ro')
% a=p; b=1;
% shape = [a b 0];

% Least squares fit (2nd order)
for i = 1:n
    s(i) = tan(2*acos(Q(i,1)));
end
s = [0; s];
w = shape_quad(node_config(:,3),s);

shape = w;
end

% Evaluate quaternion product p = qr
function [p] = q_product(qw,qx,qy,qz,rw,rx,ry,rz)
p = [0 0 0 0];
p(1) = qw*rw - qx*rx - qy*ry - qz*rz;
p(2) = qw*rx + qx*rw + qy*rz - qz*ry;
p(3) = qw*ry - qx*rz + qy*rw + qz*rx;
p(4) = qw*rz + qx*ry - qy*rx + qz*rw;
end

% Evaluate quaternion quotient p = q/r = qr_inv
function [p] = q_quotient(qw,qx,qy,qz,rw,rx,ry,rz)
p = [0 0 0 0];
p(1) =  qw*rw + qx*rx + qy*ry + qz*rz;
p(2) = -qw*rx + qx*rw - qy*rz + qz*ry;
p(3) = -qw*ry + qx*rz + qy*rw - qz*rx;
p(4) = -qw*rz - qx*ry + qy*rx + qz*rw;
end

% Evaluate rotation operator qvq* on vector v
function [r] = qvqi(qw,qx,qy,qz,vx,vy,vz)
[p] = q_quotient(0,vx,vy,vz,qw,qx,qy,qz);
[r] = q_product(qw,qx,qy,qz,p(1),p(2),p(3),p(4));
if r(1)~=0
    display('qvqi(0) is nonzero')
    display(['qvqi(0) = ' num2str(r(1))]);
end
r = r(2:4);
end