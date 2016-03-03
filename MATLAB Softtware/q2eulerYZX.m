function [rx,ry,rz] = q2eulerYZX(q)
% converts quaternion q to Euler angles using YZX sequence

rx = -atan((2*q(3)*q(4) - 2*q(1)*q(2))/(2*q(1)^2 + 2*q(3)^2 - 1));
ry = -atan((2*q(2)*q(4) - 2*q(1)*q(3))/(2*q(1)^2 + 2*q(2)^2 - 1));
rz = asin(2*q(2)*q(3) + 2*q(1)*q(4));

if rz == pi/2
    if (2*q(2)*q(3) + 2*q(1)*q(4)) == 1
        rx = asin(1);
        ry = acos(1);
    elseif (2*q(2)*q(3) + 2*q(1)*q(4)) == -1
        rx = acos(1);
        ry = asin(1);
    end
elseif rz == -pi/2
    if (2*q(2)*q(3) + 2*q(1)*q(4)) == 1
        rx = -pi/2;
    elseif (2*q(2)*q(3) + 2*q(1)*q(4)) == -1
        rx = pi/2;
    end
    ry = 0;
end