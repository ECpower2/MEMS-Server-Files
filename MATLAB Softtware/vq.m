function [r] = vq(q,v)
% Evaluate rotation operator qvq* on vector v
qv = [0 v];
[p] = q_quot(qv,q);
[r] = q_prod(q,p);
% if r(1)~=0
%     warning(['Warning: vq(0) is nonzero. vq(0) = ' num2str(r(1))])
% end
r = r(2:4);
end