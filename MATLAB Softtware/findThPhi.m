function [theta,phi] = findThPhi(angle)

alpha = angle*pi/180;
theta = acos(sin(alpha/2)+cos(alpha/2))-acos(cos(alpha/2)-sin(alpha/2));
phi = acos(sin(alpha/2)+cos(alpha/2))+acos(cos(alpha/2)-sin(alpha/2));