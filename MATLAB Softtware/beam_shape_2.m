function shape = beam_shape_2(q0w,q0x,q0y,q0z,q1w,q1x,q1y,q1z,q2w,q2x,q2y,q2z)
% Outputs 2nd order fit for beam deflection shape based on global
% quaternion output of three MotionNodes: reference q0 and rotated nodes q1
% and q2

% Coordinate system:
% x = edgewise (in plane)
% y = flapwise (out of plane)
% z = beam axis

% Node locations
node1 = [0 0 0.5];
node2 = [0 0 1];

% Find orientation of q1 and q2 relative to q0: p1=q1/q0 and p2=q2/q0
[p1w,p1x,p1y,p1z] = q_quotient(q1w,q1x,q1y,q1z,q0w,q0x,q0y,q0z);
[p2w,p2x,p2y,p2z] = q_quotient(q2w,q2x,q2y,q2z,q0w,q0x,q0y,q0z);

% ??? extra step to correct for initial misalignment between reference and
% measurement nodes ???

[~,z1j,z1k] = qvqi(p1w,p1x,p1y,p1z,0,0,1);
[~,z2j,z2k] = qvqi(p2w,p2x,p2y,p2z,0,0,1);

% Fit to quadratic curve
s1 = z1j/z1k;
s2 = z2j/z2k;
a = .5*(s2-s1)/(node2(3)-node1(3));
b = s1 - (s2-s1)*node1(3)/(node2(3)-node1(3));

% Plot beam shape
Z = linspace(0,1);
plot(Z,a*Z.^2+b*Z)
hold on
plot([0 node1(3) node2(3)],[0 a*node1(3)^2+b*node1(3) a*node2(3)^2+b*node2(3)],'o')

shape = [a b 0];
end

% Evaluate quaternion product p = qr
function [pw,px,py,pz] = q_product(qw,qx,qy,qz,rw,rx,ry,rz)
pw = qw*rw - qx*rx - qy*ry - qz*rz;
px = qw*rx + qx*rw + qy*rz - qz*ry;
py = qw*ry - qx*rz + qy*rw + qz*rx;
pz = qw*rz + qx*ry - qy*rx + qz*rw;
end

% Evaluate quaternion quotient p = q/r = qr_inv
function [pw,px,py,pz] = q_quotient(qw,qx,qy,qz,rw,rx,ry,rz)
pw =  qw*rw + qx*rx + qy*ry + qz*rz;
px = -qw*rx + qx*rw - qy*rz + qz*ry;
py = -qw*ry + qx*rz + qy*rw - qz*rx;
pz = -qw*rz - qx*ry + qy*rx + qz*rw;
end

% Evaluate rotation operator qvq* on vector v
function [rx,ry,rz] = qvqi(qw,qx,qy,qz,vx,vy,vz)
[a,b,c,d] = q_quotient(0,vx,vy,vz,qw,qx,qy,qz);
[z,rx,ry,rz] = q_product(qw,qx,qy,qz,a,b,c,d);
if z~=0
    display('qvqi(0) is nonzero')
    display(['qvqi(0) = ' num2str(z)]);
end
end