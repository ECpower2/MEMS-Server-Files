function c = correct_axis(a,b,err)

% finds correct quaternion c from original quaternion a where b has been
% rotated about an axis that differs from the correct axis by err

q1 = q_quot(b,a);
angle = 2*acos(q1(1));
axis = [q1(2)/sin(angle/2) q1(3)/sin(angle/2) q1(4)/sin(angle/2)];
d = axis - err;
% check that d is normalized
if sum(d.^2) ~= 1
    d(1) = d(1)/sum(d.^2);
    d(2) = d(2)/sum(d.^2);
    d(3) = d(3)/sum(d.^2);
end
q2 = [cos(angle/2) d(1)*sin(angle/2) d(2)*sin(angle/2) d(3)*sin(angle/2)];
c = q_prod(q2,a);

