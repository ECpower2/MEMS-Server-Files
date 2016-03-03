import_beamSept0

mz5 = sqrt(48.973^2-mx5.^2-my5.^2);
mx5 = -mx5;
my5 = -my5;

theta0 = asin(az0./sqrt(ax0.^2+ay0.^2+az0.^2));
theta1 = asin(az1./sqrt(ax1.^2+ay1.^2+az1.^2));
theta2 = asin(az2./sqrt(ax2.^2+ay2.^2+az2.^2));
theta3 = asin(az3./sqrt(ax3.^2+ay3.^2+az3.^2));
theta4 = asin(az4./sqrt(ax4.^2+ay4.^2+az4.^2));
theta5 = asin(az5./sqrt(ax5.^2+ay5.^2+az5.^2));

% phi0 = acos((ay0./sqrt(ax0.^2+ay0.^2+az0.^2))./cos(theta0));
% phi1 = acos((ay1./sqrt(ax1.^2+ay1.^2+az1.^2))./cos(theta1));
% phi2 = acos((ay2./sqrt(ax2.^2+ay2.^2+az2.^2))./cos(theta2));
% phi3 = acos((ay3./sqrt(ax3.^2+ay3.^2+az3.^2))./cos(theta3));
% phi4 = acos((ay4./sqrt(ax4.^2+ay4.^2+az4.^2))./cos(theta4));
% phi5 = acos((ay5./sqrt(ax5.^2+ay5.^2+az5.^2))./cos(theta5));

phi0 = asin((ax0./sqrt(ax0.^2+ay0.^2+az0.^2))./cos(theta0));
phi1 = asin((ax1./sqrt(ax1.^2+ay1.^2+az1.^2))./cos(theta1));
phi2 = asin((ax2./sqrt(ax2.^2+ay2.^2+az2.^2))./cos(theta2));
phi3 = asin((ax3./sqrt(ax3.^2+ay3.^2+az3.^2))./cos(theta3));
phi4 = asin((ax4./sqrt(ax4.^2+ay4.^2+az4.^2))./cos(theta4));
phi5 = asin((ax5./sqrt(ax5.^2+ay5.^2+az5.^2))./cos(theta5));

b_m0 = [mz0 -mx0 -my0]/norm([mx0 my0 mz0]);
b_m1 = [mz1 -mx1 -my1]/norm([mx1 my1 mz1]);
b_m2 = [mz2 -mx2 -my2]/norm([mx2 my2 mz2]);
b_m3 = [mz3 -mx3 -my3]/norm([mx3 my3 mz3]);
b_m4 = [mz4 -mx4 -my4]/norm([mx4 my4 mz4]);
b_m5 = [mz5 -mx5 -my5]/norm([mx5 my5 mz5]);

% nx = 19.104/19.105;
% ny = 0.205/19.105;
nx = 19.1171/norm([19.1171 .1219]);
ny = .1219/norm([19.1171 .1219]);

psi0 = zeros(46,1); psi1 = psi0; psi2 = psi0; psi3 = psi0;
psi4 = psi0; psi5 = psi0;

for i = 1:46
%     r0 = [1 0 0; 0 cos(phi0(i)) sin(phi0(i)); 0 -sin(phi0(i)) cos(phi0(i))]...
%         *[cos(theta0(i)) 0 -sin(theta0(i)); 0 1 0; ...
%         sin(theta0(i)) 0 cos(theta0(i))];
%     r1 = [1 0 0; 0 cos(phi1(i)) sin(phi1(i)); 0 -sin(phi1(i)) cos(phi1(i))]...
%         *[cos(theta1(i)) 0 -sin(theta1(i)); 0 1 0; ...
%         sin(theta1(i)) 0 cos(theta1(i))];
%     r2 = [1 0 0; 0 cos(phi2(i)) sin(phi2(i)); 0 -sin(phi2(i)) cos(phi2(i))]...
%         *[cos(theta2(i)) 0 -sin(theta2(i)); 0 1 0; ...
%         sin(theta2(i)) 0 cos(theta2(i))];
%     r3 = [1 0 0; 0 cos(phi3(i)) sin(phi3(i)); 0 -sin(phi3(i)) cos(phi3(i))]...
%         *[cos(theta3(i)) 0 -sin(theta3(i)); 0 1 0; ...
%         sin(theta3(i)) 0 cos(theta3(i))];
%     r4 = [1 0 0; 0 cos(phi4(i)) sin(phi4(i)); 0 -sin(phi4(i)) cos(phi4(i))]...
%         *[cos(theta4(i)) 0 -sin(theta4(i)); 0 1 0; ...
%         sin(theta4(i)) 0 cos(theta4(i))];
%     r5 = [1 0 0; 0 cos(phi5(i)) sin(phi5(i)); 0 -sin(phi5(i)) cos(phi5(i))]...
%         *[cos(theta5(i)) 0 -sin(theta5(i)); 0 1 0; ...
%         sin(theta5(i)) 0 cos(theta5(i))];
    r0 = [cos(theta0(i)) 0 -sin(theta0(i)); 0 1 0; ...
        sin(theta0(i)) 0 cos(theta0(i))]*[1 0 0; ...
        0 cos(phi0(i)) sin(phi0(i)); 0 -sin(phi0(i)) cos(phi0(i))];
    r1 = [cos(theta1(i)) 0 -sin(theta1(i)); 0 1 0; ...
        sin(theta1(i)) 0 cos(theta1(i))]*[1 0 0; ...
        0 cos(phi1(i)) sin(phi1(i)); 0 -sin(phi1(i)) cos(phi1(i))];
    r2 = [cos(theta2(i)) 0 -sin(theta2(i)); 0 1 0; ...
        sin(theta2(i)) 0 cos(theta2(i))]*[1 0 0; ...
        0 cos(phi2(i)) sin(phi2(i)); 0 -sin(phi2(i)) cos(phi2(i))];
    r3 = [cos(theta3(i)) 0 -sin(theta3(i)); 0 1 0; ...
        sin(theta3(i)) 0 cos(theta3(i))]*[1 0 0; ...
        0 cos(phi3(i)) sin(phi3(i)); 0 -sin(phi3(i)) cos(phi3(i))];
    r4 = [cos(theta4(i)) 0 -sin(theta4(i)); 0 1 0; ...
        sin(theta4(i)) 0 cos(theta4(i))]*[1 0 0; ...
        0 cos(phi4(i)) sin(phi4(i)); 0 -sin(phi4(i)) cos(phi4(i))];
    r5 = [cos(theta5(i)) 0 -sin(theta5(i)); 0 1 0; ...
        sin(theta5(i)) 0 cos(theta5(i))]*[1 0 0; 0 ...
        cos(phi5(i)) sin(phi5(i)); 0 -sin(phi5(i)) cos(phi5(i))];
    e_m0 = r0*b_m0(i,:)';
    e_m1 = r1*b_m1(i,:)';
    e_m2 = r2*b_m2(i,:)';
    e_m3 = r3*b_m3(i,:)';
    e_m4 = r4*b_m4(i,:)';
    e_m5 = r5*b_m5(i,:)';
    emx0 = e_m0(1)/sqrt(e_m0(1)^2+e_m0(2)^2);
    emy0 = e_m0(2)/sqrt(e_m0(1)^2+e_m0(2)^2);
    emx1 = e_m1(1)/sqrt(e_m1(1)^2+e_m1(2)^2);
    emy1 = e_m1(2)/sqrt(e_m1(1)^2+e_m1(2)^2);
    emx2 = e_m2(1)/sqrt(e_m2(1)^2+e_m2(2)^2);
    emy2 = e_m2(2)/sqrt(e_m2(1)^2+e_m2(2)^2);
    emx3 = e_m3(1)/sqrt(e_m3(1)^2+e_m3(2)^2);
    emy3 = e_m3(2)/sqrt(e_m3(1)^2+e_m3(2)^2);
    emx4 = e_m4(1)/sqrt(e_m4(1)^2+e_m4(2)^2);
    emy4 = e_m4(2)/sqrt(e_m4(1)^2+e_m4(2)^2);
    emx5 = e_m5(1)/sqrt(e_m5(1)^2+e_m5(2)^2);
    emy5 = e_m5(2)/sqrt(e_m5(1)^2+e_m5(2)^2);
    
    psi0(i) = acos(nx*emx0 + ny*emy0);
    psi1(i) = acos(nx*emx1 + ny*emy1);
    psi2(i) = acos(nx*emx2 + ny*emy2);
    psi3(i) = acos(nx*emx3 + ny*emy3);
    psi4(i) = acos(nx*emx4 + ny*emy4);
    psi5(i) = acos(nx*emx5 + ny*emy5);
end

% figure
% plot(disp1,theta0,'.',disp1,theta1,'.',disp1,theta2,'.')
% hold on
% plot(disp1,theta3,'.',disp1,theta4,'.',disp1,theta5,'.')
% ylabel('theta')
% 
% figure
% plot(disp1,phi0,'.',disp1,phi1,'.',disp1,phi2,'.')
% hold on
% plot(disp1,phi3,'.',disp1,phi4,'.',disp1,phi5,'.')
% ylabel('phi')
% 
% figure
% plot(disp1,psi0,'.',disp1,psi1,'.',disp1,psi2,'.')
% hold on
% plot(disp1,psi3,'.',disp1,psi4,'.',disp1,psi5,'.')
% ylabel('psi')

% theta0 = theta0 - theta0(1);
% theta1 = theta1 - theta1(1);
% theta2 = theta2 - theta2(1);
% theta3 = theta3 - theta3(1);
% theta4 = theta4 - theta4(1);
% theta5 = theta5 - theta5(1);

% phi0 = phi0 - phi0(1);
% phi1 = phi1 - phi1(1);
% phi2 = phi2 - phi2(1);
% phi3 = phi3 - phi3(1);
% phi4 = phi4 - phi4(1);
% phi5 = phi5 - phi5(1);

% psi0 = psi0 - psi0(1);
% psi1 = psi1 - psi1(1);
% psi2 = psi2 - psi2(1);
% psi3 = psi3 - psi3(1);
% psi4 = psi4 - psi4(1);
% psi5 = psi5 - psi5(1);

dtheta1 = theta1 - theta0;
dtheta2 = theta2 - theta0;
dtheta3 = theta3 - theta0;
dtheta4 = theta4 - theta0;
dtheta5 = theta5 - theta0;
dtheta0 = theta0 - theta0;

dphi1 = phi1 - phi0;
dphi2 = phi2 - phi0;
dphi3 = phi3 - phi0;
dphi4 = phi4 - phi0;
dphi5 = phi5 - phi0;
dphi0 = phi0 - phi0;

dpsi1 = psi1 - psi0;
dpsi2 = psi2 - psi0;
dpsi3 = psi3 - psi0;
dpsi4 = psi4 - psi0;
dpsi5 = psi5 - psi0;
dpsi0 = psi0 - psi0;

% theta0 = theta0 - theta0(43);
% theta1 = theta1 - theta0 - (theta1(43) - theta0(43));
% theta2 = theta2 - theta0 - (theta2(43) - theta0(43));
% theta3 = theta3 - theta0 - (theta3(43) - theta0(43));
% theta4 = theta4 - theta0 - (theta4(43) - theta0(43));
% theta5 = theta5 - theta0 - (theta5(43) - theta0(43));
% 
% phi0 = phi0 - phi0(43);
% phi1 = phi1 - phi0 - (phi1(43) - phi0(43));
% phi2 = phi2 - phi0 - (phi2(43) - phi0(43));
% phi3 = phi3 - phi0 - (phi3(43) - phi0(43));
% phi4 = phi4 - phi0 - (phi4(43) - phi0(43));
% phi5 = phi5 - phi0 - (phi5(43) - phi0(43));
% 
% psi0 = psi0 - psi0(43);
% psi1 = psi1 - psi0 - (psi1(43) - psi0(43));
% psi2 = psi2 - psi0 - (psi2(43) - psi0(43));
% psi3 = psi3 - psi0 - (psi3(43) - psi0(43));
% psi4 = psi4 - psi0 - (psi4(43) - psi0(43));
% psi5 = psi5 - psi0 - (psi5(43) - psi0(43));

% figure
% plot(disp1,dtheta0,'.',disp1,dtheta1,'.',disp1,dtheta2,'.')
% hold on
% plot(disp1,dtheta3,'.',disp1,dtheta4,'.',disp1,dtheta5,'.')
% ylabel('dtheta')
% 
% figure
% plot(disp1,dphi0,'.',disp1,dphi1,'.',disp1,dphi2,'.')
% hold on
% plot(disp1,dphi3,'.',disp1,dphi4,'.',disp1,dphi5,'.')
% ylabel('dphi')
% 
% figure
% plot(disp1,dpsi0,'.',disp1,dpsi1,'.',disp1,dpsi2,'.')
% hold on
% plot(disp1,dpsi3,'.',disp1,dpsi4,'.',disp1,dpsi5,'.')
% ylabel('dpsi')

A = [dtheta0 dtheta1 dtheta2 dtheta3 dtheta4 dtheta5];
A = tan(A);
sensor_loc = [0 .029 .209 .389 .569 .749];

p1 = zeros(46,1); p2 = p1; p3 = p1; rsquare = p1;

for i = 1:46
    [f,gof] = fit(sensor_loc', A(i,:)','poly2');
    p1(i) = f.p1; p2(i) = f.p2; p3(i) = f.p3;
    rsquare(i) = gof.rsquare;
end

Mth = [dtheta0 dtheta1 dtheta2 dtheta3 dtheta4 dtheta5];
Mps = [dpsi0 dpsi1 dpsi2 dpsi3 dpsi4 dpsi5];
Mph = [dphi0 dphi1 dphi2 dphi3 dphi4 dphi5];
Mf = [p1 p2 p3 rsquare];
M = [Mth Mps Mph Mf];

% quaternions
qe0 = zeros(46,4); qe1 = qe0; qe2 = qe0; qe3 = qe0;
qe4 = qe0; qe5 = qe0; qr0 = qe0; qr1 = qe0; qr2 = qr0;
qr3 = qr0; qr4 = qr0; qr5 = qr0; qa0 = qe0; qa1 = qe0;
qa2 = qa0; qa3 = qa0; qa4 = qa0; qa5 = qa0; q0 = qe0;
q1 = q0; q2 = q0; q3 = q0; q4 = q0; q5 = q0; qt0 = q0;
qt1 = q0; qt2 = q0; qt3 = q0; qt4 = q0; qt5 = q0;
rx1 = zeros(46,1); ry1 = rx1; rz1 = rx1; rx2 = rx1; ry2 = rx1; rz2 = rx1;
rx3 = rx1; ry3 = rx1; rz3 = rx1; rx4 = rx1; ry4 = rx1; rz4 = rx1;
rx5 = rx1; ry5 = rx1; rz5 = rx1;

for i = 1:46
    sth = az0(i)/sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2);
    cth = sqrt(1-sth^2);
    qe0(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax0(i)/(cth*sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2));
    cph = ay0(i)/(cth*sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2));
    qr0(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb0 = [0 b_m0(i,:)];
%     e_m = q_quot(qb0,qr0(i,:));
%     e_m = q_prod(qe0(i,:),q_prod(qr0(i,:),q_quot(e_m,qe0(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe0(i,:),qr0(i,:)),b_m0(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr0(i,:),qe0(i,:))),b_m0(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa0(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    sth = az1(i)/sqrt(ax1(i)^2 + ay1(i)^2 + az1(i)^2);
    cth = sqrt(1-sth^2);
    qe1(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax1(i)/(cth*sqrt(ax1(i)^2 + ay1(i)^2 + az1(i)^2));
    cph = ay1(i)/(cth*sqrt(ax1(i)^2 + ay1(i)^2 + az1(i)^2));
    qr1(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb1 = [0 b_m1(i,:)];
%     e_m = q_quot(qb1,qr1(i,:));
%     e_m = q_prod(qe1(i,:),q_prod(qr1(i,:),q_quot(e_m,qe1(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe1(i,:),qr1(i,:)),b_m1(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr1(i,:),qe1(i,:))),b_m1(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa1(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    sth = az2(i)/sqrt(ax2(i)^2 + ay2(i)^2 + az2(i)^2);
    cth = sqrt(1-sth^2);
    qe2(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax2(i)/(cth*sqrt(ax2(i)^2 + ay2(i)^2 + az2(i)^2));
    cph = ay2(i)/(cth*sqrt(ax2(i)^2 + ay2(i)^2 + az2(i)^2));
    qr2(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb2 = [0 b_m2(i,:)];
%     e_m = q_quot(qb2,qr2(i,:));
%     e_m = q_prod(qe2(i,:),q_prod(qr2(i,:),q_quot(e_m,qe2(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe2(i,:),qr2(i,:)),b_m2(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr2(i,:),qe2(i,:))),b_m2(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa2(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    sth = az3(i)/sqrt(ax3(i)^2 + ay3(i)^2 + az3(i)^2);
    cth = sqrt(1-sth^2);
    qe3(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax3(i)/(cth*sqrt(ax3(i)^2 + ay3(i)^2 + az3(i)^2));
    cph = ay3(i)/(cth*sqrt(ax3(i)^2 + ay3(i)^2 + az3(i)^2));
    qr3(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb3 = [0 b_m3(i,:)];
%     e_m = q_quot(qb3,qr3(i,:));
%     e_m = q_prod(qe3(i,:),q_prod(qr3(i,:),q_quot(e_m,qe3(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe3(i,:),qr3(i,:)),b_m3(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr3(i,:),qe3(i,:))),b_m3(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa3(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    sth = az4(i)/sqrt(ax4(i)^2 + ay4(i)^2 + az4(i)^2);
    cth = sqrt(1-sth^2);
    qe4(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax4(i)/(cth*sqrt(ax4(i)^2 + ay4(i)^2 + az4(i)^2));
    cph = ay4(i)/(cth*sqrt(ax4(i)^2 + ay4(i)^2 + az4(i)^2));
    qr4(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb4 = [0 b_m4(i,:)];
%     e_m = q_quot(qb4,qr4(i,:));
%     e_m = q_prod(qe4(i,:),q_prod(qr4(i,:),q_quot(e_m,qe4(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe4(i,:),qr4(i,:)),b_m4(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr4(i,:),qe4(i,:))),b_m4(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa4(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    sth = az5(i)/sqrt(ax5(i)^2 + ay5(i)^2 + az5(i)^2);
    cth = sqrt(1-sth^2);
    qe5(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax5(i)/(cth*sqrt(ax5(i)^2 + ay5(i)^2 + az5(i)^2));
    cph = ay5(i)/(cth*sqrt(ax5(i)^2 + ay5(i)^2 + az5(i)^2));
    qr5(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
%     qb5 = [0 b_m5(i,:)];
%     e_m = q_quot(qb5,qr5(i,:));
%     e_m = q_prod(qe5(i,:),q_prod(qr5(i,:),q_quot(e_m,qe5(i,:))));
%     e_m = e_m(2:4);
%     e_m = vq(q_prod(qe5(i,:),qr5(i,:)),b_m5(i,:));
    e_m = vq(q_quot([1 0 0 0],q_prod(qr5(i,:),qe5(i,:))),b_m5(i,:));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa5(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
   
%     q0(i,:) = q_prod(qa0(i,:),q_prod(qe0(i,:),qr0(i,:)));
%     q1(i,:) = q_prod(qa1(i,:),q_prod(qe1(i,:),qr1(i,:)));
%     q2(i,:) = q_prod(qa2(i,:),q_prod(qe2(i,:),qr2(i,:)));
%     q3(i,:) = q_prod(qa3(i,:),q_prod(qe3(i,:),qr3(i,:)));
%     q4(i,:) = q_prod(qa4(i,:),q_prod(qe4(i,:),qr4(i,:)));
%     q5(i,:) = q_prod(qa5(i,:),q_prod(qe5(i,:),qr5(i,:)));
   
    q0(i,:) = q_prod(q_quot(qa0(i,:),qa0(1,:)),q_prod(qe0(i,:),qr0(i,:)));
    q1(i,:) = q_prod(q_quot(qa1(i,:),qa1(1,:)),q_prod(qe1(i,:),qr1(i,:)));
    q2(i,:) = q_prod(q_quot(qa2(i,:),qa2(1,:)),q_prod(qe2(i,:),qr2(i,:)));
    q3(i,:) = q_prod(q_quot(qa3(i,:),qa3(1,:)),q_prod(qe3(i,:),qr3(i,:)));
    q4(i,:) = q_prod(q_quot(qa4(i,:),qa4(1,:)),q_prod(qe4(i,:),qr4(i,:)));
    q5(i,:) = q_prod(q_quot(qa5(i,:),qa5(1,:)),q_prod(qe5(i,:),qr5(i,:)));
    
    qt0(i,:) = q_quot(q0(i,:),q0(i,:));
%     qt1(i,:) = q_quot(q1(i,:),q0(i,:));
    qt2(i,:) = q_quot(q2(i,:),q0(i,:));
    qt3(i,:) = q_quot(q3(i,:),q0(i,:));
    qt4(i,:) = q_quot(q4(i,:),q0(i,:));
    qt5(i,:) = q_quot(q5(i,:),q0(i,:));

%     qt0(i,:) = q_quot(q0(i,:),q0(1,:));
%     qt1(i,:) = q_quot(q1(i,:),q1(1,:));
%     qt2(i,:) = q_quot(q2(i,:),q2(1,:));
%     qt3(i,:) = q_quot(q3(i,:),q3(1,:));
%     qt4(i,:) = q_quot(q4(i,:),q4(1,:));
%     qt5(i,:) = q_quot(q5(i,:),q5(1,:));

%     qt0(i,:) = q_quot(q_quot(q0(i,:),q0(i,:)),q_quot(q0(1,:),q0(1,:)));
%     qt1(i,:) = q_quot(q_quot(q1(i,:),q0(i,:)),q_quot(q1(1,:),q0(1,:)));
%     qt2(i,:) = q_quot(q_quot(q2(i,:),q0(i,:)),q_quot(q2(1,:),q0(1,:)));
%     qt3(i,:) = q_quot(q_quot(q3(i,:),q0(i,:)),q_quot(q3(1,:),q0(1,:)));
%     qt4(i,:) = q_quot(q_quot(q4(i,:),q0(i,:)),q_quot(q4(1,:),q0(1,:)));
%     qt5(i,:) = q_quot(q_quot(q5(i,:),q0(i,:)),q_quot(q5(1,:),q0(1,:)));

%     qt0(i,:) = q_quot(q_quot(q0(i,:),q0(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt1(i,:) = q_quot(q_quot(q1(i,:),q1(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt2(i,:) = q_quot(q_quot(q2(i,:),q2(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt3(i,:) = q_quot(q_quot(q3(i,:),q3(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt4(i,:) = q_quot(q_quot(q4(i,:),q4(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt5(i,:) = q_quot(q_quot(q5(i,:),q5(1,:)),q_quot(q0(i,:),q0(1,:)));

%     qt0(i,:) = q_quot(q_quot(q0(i,:),q0(1,:)),q_quot(q0(i,:),q0(1,:)));
    qt1(i,:) = q_quot(q_quot(q1(i,:),q1(1,:)),q_quot(q0(i,:),q0(1,:)));
%     qt2(i,:) = q_quot(q_quot(q2(i,:),q2(43,:)),q_quot(q0(i,:),q0(43,:)));
%     qt3(i,:) = q_quot(q_quot(q3(i,:),q3(43,:)),q_quot(q0(i,:),q0(43,:)));
%     qt4(i,:) = q_quot(q_quot(q4(i,:),q4(44,:)),q_quot(q0(i,:),q0(44,:)));
%     qt5(i,:) = q_quot(q_quot(q5(i,:),q5(3,:)),q_quot(q0(i,:),q0(3,:)));

    [rx1(i),ry1(i),rz1(i)] = q2euler(qt1(i,:));
    [rx2(i),ry2(i),rz2(i)] = q2euler(q2(i,:));
    [rx3(i),ry3(i),rz3(i)] = q2euler(qt3(i,:));
    [rx4(i),ry4(i),rz4(i)] = q2euler(qt4(i,:));
    [rx5(i),ry5(i),rz5(i)] = q2euler(qt5(i,:));
end

B = [zeros(46,1) ry1 ry2 ry3 ry4 ry5];
B = tan(B);
sensor_loc = [0 .029 .209 .389 .569 .749];

pq1 = zeros(46,1); pq2 = pq1; pq3 = pq1; rsquareq = pq1;

for i = 1:46
    [f,gof] = fit(sensor_loc', B(i,:)','poly2');
    pq1(i) = f.p1; pq2(i) = f.p2; pq3(i) = f.p3;
    rsquareq(i) = gof.rsquare;
end

Nx = [rx1 rx2 rx3 rx4 rx5];
Ny = [ry1 ry2 ry3 ry4 ry5];
Nz = [rz1 rz2 rz3 rz4 rz5];
Nf = [pq1 pq2 pq3 rsquareq];
N = [Ny Nx Nz Nf];

% FQA
fqa_q0 = fqa(az0,-ax0,-ay0,mz0,-mx0,-my0);
fqa_q1 = fqa(az1,-ax1,-ay1,mz1,-mx1,-my1);
fqa_q2 = fqa(az2,-ax2,-ay2,mz2,-mx2,-my2);
fqa_q3 = fqa(az3,-ax3,-ay3,mz3,-mx3,-my3);
fqa_q4 = fqa(az4,-ax4,-ay4,mz4,-mx4,-my4);
fqa_q5 = fqa(az5,-ax5,-ay5,mz5,-mx5,-my5);

% [fqa_q0,fq_e0,fq_r0,fq_a0] = fqa_x(az0,-ax0,-ay0,mz0,-mx0,-my0);
% [fqa_q1,fq_e1,fq_r1,fq_a1] = fqa_x(az1,-ax1,-ay1,mz1,-mx1,-my1);
% [fqa_q2,fq_e2,fq_r2,fq_a2] = fqa_x(az2,-ax2,-ay2,mz2,-mx2,-my2);
% [fqa_q3,fq_e3,fq_r3,fq_a3] = fqa_x(az3,-ax3,-ay3,mz3,-mx3,-my3);
% [fqa_q4,fq_e4,fq_r4,fq_a4] = fqa_x(az4,-ax4,-ay4,mz4,-mx4,-my4);
% [fqa_q5,fq_e5,fq_r5,fq_a5] = fqa_x(az5,-ax5,-ay5,mz5,-mx5,-my5);

% figure
% plot(disp1,q2eulerN(fqa_q0),'.',disp1(1:42),phi0(1:42))
% hold on; plot(disp1(1:42),psi0(1:42),disp1(1:42),theta0(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')
% figure
% plot(disp1,q2eulerN(fqa_q1),'.',disp1(1:42),phi1(1:42))
% hold on; plot(disp1(1:42),psi1(1:42),disp1(1:42),theta1(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')
% figure
% plot(disp1,q2eulerN(fqa_q2),'.',disp1(1:42),phi2(1:42))
% hold on; plot(disp1(1:42),psi2(1:42),disp1(1:42),theta2(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')
% figure
% plot(disp1,q2eulerN(fqa_q3),'.',disp1(1:42),phi3(1:42))
% hold on; plot(disp1(1:42),psi3(1:42),disp1(1:42),theta3(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')
% figure
% plot(disp1,q2eulerN(fqa_q4),'.',disp1(1:42),phi4(1:42))
% hold on; plot(disp1(1:42),psi4(1:42),disp1(1:42),theta4(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')
% figure
% plot(disp1,q2eulerN(fqa_q5),'.',disp1(1:42),phi5(1:42))
% hold on; plot(disp1(1:42),psi5(1:42),disp1(1:42),theta5(1:42))
% legend('fqa x','fqa y','fqa z','phi','psi','theta')

% fr0 = q2eulerN(fqa_q0);
% fr1 = q2eulerN(fqa_q1);
fr2 = q2eulerN(fqa_q2);
% fr3 = q2eulerN(fqa_q3);
% fr4 = q2eulerN(fqa_q4);
% fr5 = q2eulerN(fqa_q5);

fr1 = q2eulerN(q_quotN(q_quotN(fqa_q1,fqa_q0),q_quot(fqa_q1(1,:),fqa_q0(1,:))));
% fr1 = q2eulerN(q_quotN(fqa_q1,fqa_q0));
% fr2 = q2eulerN(q_quotN(fqa_q2,fqa_q0));
fr3 = q2eulerN(q_quotN(fqa_q3,fqa_q0));
fr4 = q2eulerN(q_quotN(fqa_q4,fqa_q0));
fr5 = q2eulerN(q_quotN(fqa_q5,fqa_q0));

% figure
% plot(disp1(1:42),fr1(1:42,:),'.')
% hold on
% plot(disp1(1:42),rx1(1:42,:),disp1(1:42),ry1(1:42,:),disp1(1:42),rz1(1:42,:))
% plot(disp1(1:42),dphi1(1:42,:),'.-',disp1(1:42),dtheta1(1:42,:),'.-',disp1(1:42),dpsi1(1:42,:),'.-')
% title('1'); legend('fqa x','fqa y','fqa z','x','y','z','phi','theta','psi')
% 
% figure
% plot(disp1(1:42),fr2(1:42,:),'.')
% hold on
% plot(disp1(1:42),rx2(1:42,:),disp1(1:42),ry2(1:42,:),disp1(1:42),rz2(1:42,:))
% plot(disp1(1:42),dphi2(1:42,:),'.-',disp1(1:42),dtheta2(1:42,:),'.-',disp1(1:42),dpsi2(1:42,:),'.-')
% title('2'); legend('fqa x','fqa y','fqa z','x','y','z','phi','theta','psi')
% 
% figure
% plot(disp1(1:42),fr3(1:42,:),'.')
% hold on
% plot(disp1(1:42),rx3(1:42,:),disp1(1:42),ry3(1:42,:),disp1(1:42),rz3(1:42,:))
% plot(disp1(1:42),dphi3(1:42,:),'.-',disp1(1:42),dtheta3(1:42,:),'.-',disp1(1:42),dpsi3(1:42,:),'.-')
% title('3'); legend('fqa x','fqa y','fqa z','x','y','z','phi','theta','psi')
% 
% figure
% plot(disp1(1:42),fr4(1:42,:),'.')
% hold on
% plot(disp1(1:42),rx4(1:42,:),disp1(1:42),ry4(1:42,:),disp1(1:42),rz4(1:42,:))
% plot(disp1(1:42),dphi4(1:42,:),'.-',disp1(1:42),dtheta4(1:42,:),'.-',disp1(1:42),dpsi4(1:42,:),'.-')
% title('4'); legend('fqa x','fqa y','fqa z','x','y','z','phi','theta','psi')
% 
% figure
% plot(disp1(1:42),fr5(1:42,:),'.')
% hold on
% plot(disp1(1:42),rx5(1:42,:),disp1(1:42),ry5(1:42,:),disp1(1:42),rz5(1:42,:))
% plot(disp1(1:42),dphi5(1:42,:),'.-',disp1(1:42),dtheta5(1:42,:),'.-',disp1(1:42),dpsi5(1:42,:),'.-')
% title('5'); legend('fqa x','fqa y','fqa z','x','y','z','phi','theta','psi')

% beam theory
x1 = .029; x2 = .209; x3 = .389; x4 = .569; x5 = .749;
EI = 48.6503;
P = [3 4.46 5.92 7.38 8.83 10.29 11.75 13.21 14.67 16.12 17];
d_tip = [23 18 13 8 3 -2 -7 -12 -17 -22 -25];
s1 = P*x1.*(.794-x1/2)/EI;
s2 = P*x2.*(.794-x2/2)/EI;
s3 = P*x3.*(.794-x3/2)/EI;
s4 = P*x4.*(.794-x4/2)/EI;
s5 = P*x5.*(.794-x5/2)/EI;

m = 180/pi;

figure
plot(d_tip,s1*m,'.-')
hold on
plot(disp1(1:42),rx1(1:42,:)*m,disp1(1:42),ry1(1:42,:)*m,disp1(1:42),...
    rz1(1:42,:)*m)
plot(disp1(1:42),fr1(1:42,:)*m,'.')
title('1'); legend('E-B y','x','y','z','fqa x','fqa y','fqa z')

figure
plot(d_tip,s2*m,'.-')
hold on
plot(disp1(1:42),rx2(1:42,:)*m,disp1(1:42),ry2(1:42,:)*m,disp1(1:42),...
    rz2(1:42,:)*m)
plot(disp1(1:42),fr2(1:42,:)*m,'.')
title('2'); legend('E-B y','x','y','z','fqa x','fqa y','fqa z')

figure
plot(d_tip,s3*m,'.-')
hold on
plot(disp1(1:42),rx3(1:42,:)*m,disp1(1:42),ry3(1:42,:)*m,disp1(1:42),...
    rz3(1:42,:)*m)
plot(disp1(1:42),fr3(1:42,:)*m,'.')
title('3'); legend('E-B y','x','y','z','fqa x','fqa y','fqa z')

figure
plot(d_tip,s4*m,'.-')
hold on
plot(disp1(1:42),rx4(1:42,:)*m,disp1(1:42),ry4(1:42,:)*m,disp1(1:42),...
    rz4(1:42,:)*m)
plot(disp1(1:42),fr4(1:42,:)*m,'.')
title('4'); legend('E-B y','x','y','z','fqa x','fqa y','fqa z')

figure
plot(d_tip,s5*m,'.-')
hold on
plot(disp1(1:42),rx5(1:42,:)*m,disp1(1:42),ry5(1:42,:)*m,disp1(1:42),...
    rz5(1:42,:)*m)
plot(disp1(1:42),fr5(1:42,:)*m,'.')
title('5'); legend('E-B y','x','y','z','fqa x','fqa y','fqa z')

