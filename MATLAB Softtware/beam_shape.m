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

n = length(W)-1;
vz = zeros(3,n); vx = zeros(3,n);
sflap = zeros(n,1);
sedge = zeros(n,1);
stwist = zeros(n,1);

% Determine local coordinate system from reference node
x = qvqi(W(1),X(1),Y(1),Z(1),1,0,0);
y = qvqi(W(1),X(1),Y(1),Z(1),0,1,0);
z = qvqi(W(1),X(1),Y(1),Z(1),0,0,1);
% ??? extra step to correct for initial misalignment between reference and
% measurement nodes ???

% Find orientation of measurement nodes relative to reference node
for i = 2:n+1
    vz(:,i-1) = qvqi(W(i),X(i),Y(i),Z(i),0,0,1);
    vx(:,i-1) = qvqi(W(i),X(i),Y(i),Z(i),1,0,0);
end

% Least squares fit (2nd order)
for i = 1:n
    sflap(i) = dot(vz(:,i),y) / dot(vz(:,i),z);
    sedge(i) = dot(vz(:,i),x) / dot(vz(:,i),z);
    stwist(i) = dot(vx(:,i),y) / dot(vx(:,i),x);
end
sflap = [0; sflap];
[w,aw] = shape_quad(node_config(:,3),sflap);
dlmwrite('flap_out.csv',aw,'\t');
sedge = [0; sedge];
[v,av] = shape_quad(node_config(:,3),sedge);
dlmwrite('edge_out.csv',av,'\t');
stwist = [0; stwist];
wt1 = w - .1*sin(atan(stwist)); vt1 = v - .1*cos(atan(stwist));
wt3 = w + .1*sin(atan(stwist)); vt3 = v + .1*cos(atan(stwist));
shape = [node_config(:,3) w v stwist];
shape = aw;
figure;
plot3(node_config(:,3),vt1,wt1,'r',node_config(:,3),v,w,'k',...
    node_config(:,3),vt3,wt3,'b')
grid on
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
% Set quaternion norm = 1
p = p/sqrt(sum(p.^2));
end

function [r] = qvqi(qw,qx,qy,qz,vx,vy,vz)
% Evaluate rotation operator qvq* on vector v
[p] = q_quotient(0,vx,vy,vz,qw,qx,qy,qz);
[r] = q_product(qw,qx,qy,qz,p(1),p(2),p(3),p(4));
if r(1)~=0
    warning(['Warning: qvqi(0) is nonzero. qvqi(0) = ' num2str(r(1))])
end
r = r(2:4);
end