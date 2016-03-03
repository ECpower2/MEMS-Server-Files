function shape = beam_shape(W,X,Y,Z,node_config)
% Outputs 2nd order fit for beam deflection shape based on global
% quaternion output of MotionNodes. 
% Indices (0), (1), ... (n) denote nodes where (0) is the reference node 
% W = [Gqw(0) Gqw(1) ... Gqw(n)] 
% X = [Gqx(0) Gqx(1) ... Gqx(n)]
% Y = [Gqy(0) Gqy(1) ... Gqy(n)]
% Z = [Gqz(0) Gqz(1) ... Gqz(n)]
% node_config = [x(0) y(0) z(0); x(1) y(1) z(1); ... x(n) y(n) z(n)]
% Local coordinate system for node_config:
% x = edgewise (in plane)
% y = flapwise (out of plane)
% z = beam axis

n = length(W)-1;
Q = zeros(n,4);
s = zeros(n,1);

% Find orientation of measurement nodes relative to (0)
for i = 2:n+1
    Q(i-1,:) = q_quotient(W(i),X(i),Y(i),Z(i),W(1),X(1),Y(1),Z(1));
    if Q(i-1,1)>1
        warning(['Warning: Q(' num2str(i-1) ') > 1']);
        display(acos(Q(i-1,1)))
        display(sum(Q(i-1,:).^2)-1)
        display(Q(i-1,1)^2-1)
        display(sum(Q(i-1,2:4).^2))
    end
end

% ??? extra step to correct for initial misalignment between reference and
% measurement nodes ???

% Least squares fit (2nd order)
for i = 1:n
    s(i) = tan(2*acos(Q(i,1)));
end
s = [0; s];
shape = shape_quad(node_config(:,3),s);
end

% Evaluate quaternion quotient p = q/r = qr_inv
function [p] = q_quotient(qw,qx,qy,qz,rw,rx,ry,rz)
p = [0 0 0 0];
p(1) =  qw*rw + qx*rx + qy*ry + qz*rz;
p(2) = -qw*rx + qx*rw - qy*rz + qz*ry;
p(3) = -qw*ry + qx*rz + qy*rw - qz*rx;
p(4) = -qw*rz - qx*ry + qy*rx + qz*rw;
% Set quaternion norm = 1
p = p/sqrt(sum(p.^2));
end