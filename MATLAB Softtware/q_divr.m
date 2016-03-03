function q1 = q_divr(q,r)
% Calculate quotient q/r for a series of quaternions q and reference r
[n,c] = size(q);
q1 = zeros(n,4);   

if c==4
    for i = 1:n
        q1(i,:) = q_quot(q(i,:),r);
    end
else
    print('Input quaternions must have 4 columns')
end