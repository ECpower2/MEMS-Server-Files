function [p] = q_quotN(q,r)
% Evaluate quaternion quotient p = q/r = qr_inv/|r|
[n,~] = size(q);
[m,~] = size(r);
p = zeros(n,4);
for i=1:n
    if m==1
        j=1;    else    j=i;
    end
r2 = sqrt(r(j,1)^2+r(j,2)^2+r(j,3)^2+r(j,4)^2);
p(i,1) =  q(i,1)*r(j,1) + q(i,2)*r(j,2) + q(i,3)*r(j,3) + q(i,4)*r(j,4);
p(i,2) = -q(i,1)*r(j,2) + q(i,2)*r(j,1) - q(i,3)*r(j,4) + q(i,4)*r(j,3);
p(i,3) = -q(i,1)*r(j,3) + q(i,2)*r(j,4) + q(i,3)*r(j,1) - q(i,4)*r(j,2);
p(i,4) = -q(i,1)*r(j,4) - q(i,2)*r(j,3) + q(i,3)*r(j,2) + q(i,4)*r(j,1);
p(i,:) = p(i,:)/r2;
end
end