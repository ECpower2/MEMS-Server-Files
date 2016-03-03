 function r = q2eulerN(q)
% converts quaternion q to Euler angles using ZYX sequence
[n,~] = size(q);
rx = zeros(n,1); ry = rx; rz = rx;

for i = 1:n
rx(i) = atan2((2*q(i,3)*q(i,4) + 2*q(i,1)*q(i,2)),...
    (q(i,1)^2 - q(i,2)^2 - q(i,3)^2 + q(i,4)^2));
ry(i) = asin(2*q(i,1)*q(i,3) - 2*q(i,2)*q(i,4));
rz(i) = atan2((2*q(i,2)*q(i,3) + 2*q(i,1)*q(i,4)),...
    (q(i,1)^2 + q(i,2)^2 - q(i,3)^2 - q(i,4)^2));
end

r = [rx ry rz];