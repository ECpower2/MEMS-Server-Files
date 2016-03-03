function [L] = qrqi(qw,qx,qy,qz,rw,rx,ry,rz)
% Evaluate rotation operator qrq* on quaternion r
[p] = q_quotient(rw,rx,ry,rz,qw,qx,qy,qz);
[L] = q_product(qw,qx,qy,qz,p(1),p(2),p(3),p(4));
end