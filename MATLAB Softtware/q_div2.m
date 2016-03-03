function q2 = q_div2(q,r,s)
% Calculate quotient (q/r)/s for a series of quaternions

[n,c] = size(q);
q1 = zeros(n,4);    q2 = zeros(n,4);

if c==4
    for i = 1:n
        q1(i,:) = q_quot(q(i,:),r(i,:));
        q2(i,:) = q_quot(q1(i,:),s(i,:));
    end
else
    print('Input quaternions must have 4 columns')
end