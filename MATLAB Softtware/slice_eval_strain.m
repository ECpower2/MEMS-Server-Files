function [z,ep] = slice_eval_strain(filename)
% finds strain values along slices of blade surface corresponding to fiber
% optic strain gauge position

comsolout = dlmread(filename,',',8,0);

x_in = comsolout(:,1);
z_in = comsolout(:,2);
ep_in = comsolout(:,3);

x1 = x_in(1:1259);      x2 = x_in(1299:3295);
z1 = z_in(1:1259);      z2 = z_in(1299:3295);
ep1 = ep_in(1:1259);    ep2 = ep_in(1299:3295);

z0 = z1(x1>0);
ep0 = ep1(x1>0);

xx = smooth(x2,29);
z3 = z2(x2>xx);
ep3 = ep2(x2>xx);

z = [z0; z3];
ep = [ep0; ep3];