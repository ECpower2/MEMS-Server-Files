function [phi,theta, psi] = mg2euler(Mx,My,Mz,ax,ay,az)
% finds Euler angles based on magnetometer and accelerometer readings
% see Zhu et al (2007), Measurement, vol. 40 pp. 322-328
% coordinate system rotated 90deg about x, assumes mz = 0

phi = atan2(-az,ay);
psi = atan2(ax.*cos(phi),ay);

for i = 1:length(ay)
    if ay(i) < 0        
        if az(i) >= ay(i) && az(i) <= -ay(i)
            phi(i) = atan2(az(i),-ay(i));
            psi(i) = atan2(ax(i)*cos(phi(i)),ay(i));
        else
            psi(i) = atan2(-ax(i)*cos(phi(i)),-ay(i));
        end
    end
end

theta = -atan2((-My.*sin(phi) - Mz.*cos(phi)),(Mx.*cos(psi) + ...
    (Mz.*sin(phi) - My.*cos(phi)).*sin(psi)));