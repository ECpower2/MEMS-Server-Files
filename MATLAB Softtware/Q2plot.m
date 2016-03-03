function Q2plot(Q)
% Plots quaternion Q as three axes rotated wrt standard axes

if size(Q)==[1,4]
    x = qvq(Q,[1 0 0]); xx = [0; x(1)]; xy = [0; x(2)]; xz = [0; x(3)];
    y = qvq(Q,[0 1 0]); yx = [0; y(1)]; yy = [0; y(2)]; yz = [0; y(3)];
    z = qvq(Q,[0 0 1]); zx = [0; z(1)]; zy = [0; z(2)]; zz = [0; z(3)];
    
    figure;
    hold on
    plot3([0;1],[0;0],[0;0],'k',1,0,0,'bo');
    plot3([0;0],[0;0],[0;1],'k',0,0,1,'ro');
    plot3([0;0],[0;-1],[0;0],'k',0,-1,0,'go');
    h = plot3(xx,-xz,xy,'b',yx,-yz,yy,'r',zx,-zz,zy,'g');
    grid on
    xlim([-1 1]); ylim([-1 1]); zlim([-1 1]);
    view(45,30)
    legend(h,'x','y','z')
else
    error('quaternion Q is not a vector of length 4')
end

function y = qvq(q,v)
% Calculates product qvq* where q is a quaternion with inverse q*
q0 = q(1);
Q = [q(2) q(3) q(4)];
y = (2*q0^2-1)*v + 2*dot(Q,v)*Q + 2*q0*cross(Q,v);