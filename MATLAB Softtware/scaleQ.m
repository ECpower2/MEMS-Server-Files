function s = scaleQ(target,q)
% scales input quaternion to match angle of target quaternion

alpha = acos(target(1));
theta = acos(q(1));
delta = alpha - theta;

v = [q(2) q(3) q(4)]/sqrt(1-q(1)^2);
d = [cos(delta) sin(delta)*v];
s = q_prod(q,d);