function [p] = q_product(qw,qx,qy,qz,rw,rx,ry,rz)
% Evaluate quaternion product p = qr
p = [0 0 0 0];
p(1) = qw*rw - qx*rx - qy*ry - qz*rz;
p(2) = qw*rx + qx*rw + qy*rz - qz*ry;
p(3) = qw*ry - qx*rz + qy*rw + qz*rx;
p(4) = qw*rz + qx*ry - qy*rx + qz*rw;
end