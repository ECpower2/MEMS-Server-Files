 function [rx,ry,rz] = q2euler(q)
% converts quaternion q to Euler angles using ZYX sequence

rx = atan2((2*q(3)*q(4) + 2*q(1)*q(2)),(q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2));
ry = asin(2*q(1)*q(3) - 2*q(2)*q(4));
rz = atan2((2*q(2)*q(3) + 2*q(1)*q(4)),(q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2));

% if (q(3) > q(1) || q(3) < -q(1))
% rx = pi + rx;
% ry = -pi - asin(2*q(1)*q(3) - 2*q(2)*q(4));
% if ry<-pi
%     ry = ry + 2*pi;
% end
% rz = pi + rz;
% end
% 
% if (ry > -pi/2-0.01 && ry < -pi/2+0.01)
%     rz = pi/4;
%     rx = -asin(sqrt(2)*(q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2 + ...
%         2*(q(2)*q(3) - q(1)*q(4)))/2);
% end

% if ry == pi/2
%     if (2*q(2)*q(3) - 2*q(1)*q(4)) == 1
%         rx = asin(1);
%         rz = acos(1);
%     elseif (2*q(2)*q(3) - 2*q(1)*q(4)) == -1
%         rx = acos(1);
%         rz = asin(1);
%     end
% elseif ry == -pi/2
%     if (2*q(2)*q(3) - 2*q(1)*q(4)) == 1
%         rx = -pi/2;
%     elseif (2*q(2)*q(3) - 2*q(1)*q(4)) == -1
%         rx = pi/2;
%     end
%     rz = 0;
% end

% if q(3) > q(1)
%     rx = atan2(-(2*q(3)*q(4) + 2*q(1)*q(2)),-(q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2));
%     rz = atan2(-(2*q(2)*q(3) + 2*q(1)*q(4)),-(q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2));
% end

% if sin(rx) / (2*(q(3)*q(4) + q(1)*q(2))) > 0
%     if ry > 0 
%         if rx > 3.1; ry = pi - ry; 
%         else ry = acos(2*(q(3)*q(4) + q(1)*q(2))/sin(rx));
%         end
%     elseif ry < 0
%         if rx > 3.1; ry = -pi - ry; 
%         else ry = -acos(2*(q(3)*q(4) + q(1)*q(2))/sin(rx));
%         end
%     end
% end