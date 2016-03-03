function [r] = qvqi(qw,qx,qy,qz,vx,vy,vz)
% Evaluate rotation operator qvq* on vector v
[p] = q_quotient(0,vx,vy,vz,qw,qx,qy,qz);
[r] = q_product(qw,qx,qy,qz,p(1),p(2),p(3),p(4));
if r(1)~=0
    warning(['Warning: qvqi(0) is nonzero. qvqi(0) = ' num2str(r(1))])
end
r = r(2:4);
end