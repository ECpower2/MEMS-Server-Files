function out = heatflux(x,y,x0,y0,Q0,scale)
% See Intro to LiveLink for MATLAB p.43
radius = sqrt((x-x0).^2+(y-y0).^2);
out = Q0/5+Q0/2.*sin(scale*pi.*radius)./(scale*pi.*radius);