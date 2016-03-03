function [p] = q_quot(q,r)
% Evaluate quaternion quotient p = q/r = qr_inv/|r|
p = [0 0 0 0];
r2 = sqrt(r(1)^2+r(2)^2+r(3)^2+r(4)^2);
p(1) =  q(1)*r(1) + q(2)*r(2) + q(3)*r(3) + q(4)*r(4);
p(2) = -q(1)*r(2) + q(2)*r(1) - q(3)*r(4) + q(4)*r(3);
p(3) = -q(1)*r(3) + q(2)*r(4) + q(3)*r(1) - q(4)*r(2);
p(4) = -q(1)*r(4) - q(2)*r(3) + q(3)*r(2) + q(4)*r(1);
p = p/r2;
end