function [phi,theta,psi] = transferMEMS(ax,ay,az,Mx,My,Mz)

% magnetic field components (specific to location, slowly time-varying)
% see http://www.ngdc.noaa.gov/geomag-web/#igrfwmm for current values
% LR building coordinates: 51.990385, 4.376803
mx = 19.2457;
my = -44.8002;
mz = -.918;

x = Mx - my*ax;
y = My - my*ay;
z = Mz - my*az;

sTh = (ax*az*mx^2 + x*z - ay*mx*mz) / (mx*ax*y - ay*x*mx + mz*z);
theta = asin(sTh);
cTh = cos(theta);
sPsi = -ax / cTh;
cPsi = (x - mz*sTh) / (mx*cTh);
sPhi = (az*mx - y*sTh) / (x*cTh);
cPhi = (ay*mx + z*sTh) / (x*cTh);

psi = [asin(sPsi) acos(cPsi)];
phi = [asin(sPhi) acos(cPhi)];
end
