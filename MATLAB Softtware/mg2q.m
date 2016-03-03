function q = mg2q(ax,ay,az,Mx,My,Mz)
% converts sensor readings to quaternions (via Euler angles)
n = length(ax);

[rx,ry,rz] = mg2euler(Mx,My,Mz,ax,ay,az);

q = zeros(n,4);
q(:,1) = cos(rx/2).*cos(ry/2).*cos(rz/2) + sin(rx/2).*sin(ry/2).*sin(rz/2);
q(:,2) = sin(rx/2).*cos(ry/2).*cos(rz/2) - cos(rx/2).*sin(ry/2).*sin(rz/2);
q(:,3) = cos(rx/2).*sin(ry/2).*cos(rz/2) + sin(rx/2).*cos(ry/2).*sin(rz/2);
q(:,4) = cos(rx/2).*cos(ry/2).*sin(rz/2) - sin(rx/2).*sin(ry/2).*cos(rz/2);