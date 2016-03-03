function [p] = q_quotient(qw,qx,qy,qz,rw,rx,ry,rz)
% Evaluate quaternion quotient p = q/r = qr_inv/|r|
p = [0 0 0 0];
r2 = sqrt(rw^2+rx^2+ry^2+rz^2);
p(1) =  qw*rw + qx*rx + qy*ry + qz*rz;
p(2) = -qw*rx + qx*rw - qy*rz + qz*ry;
p(3) = -qw*ry + qx*rz + qy*rw - qz*rx;
p(4) = -qw*rz - qx*ry + qy*rx + qz*rw;
p = p/r2;
end