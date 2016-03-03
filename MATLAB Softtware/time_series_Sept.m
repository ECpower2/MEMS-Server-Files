filename = 'D:\acooperman\My Documents\Motion\beam-7mm4.csv';

[time,ax1,ay1,az1,mx1,my1,mz1,ax2,ay2,az2,mx2,my2,mz2,ax3,ay3,az3,mx3,...
    my3,mz3,ax4,ay4,az4,mx4,my4,mz4,ax5,ay5,az5,mx5,my5,mz5,ax0,ay0,az0,...
    mx0,my0,mz0] = importfileSept(filename);

ns = length(ax1);

mz5 = sqrt(48.973^2-mx5.^2-my5.^2);
mx5 = -mx5;
my5 = -my5;

theta0 = asin(az0./sqrt(ax0.^2+ay0.^2+az0.^2));
theta1 = asin(az1./sqrt(ax1.^2+ay1.^2+az1.^2));
theta2 = asin(az2./sqrt(ax2.^2+ay2.^2+az2.^2));
theta3 = asin(az3./sqrt(ax3.^2+ay3.^2+az3.^2));
theta4 = asin(az4./sqrt(ax4.^2+ay4.^2+az4.^2));
theta5 = asin(az5./sqrt(ax5.^2+ay5.^2+az5.^2));

phi0 = acos((ay0./sqrt(ax0.^2+ay0.^2+az0.^2))./cos(theta0));
phi1 = acos((ay1./sqrt(ax1.^2+ay1.^2+az1.^2))./cos(theta1));
phi2 = acos((ay2./sqrt(ax2.^2+ay2.^2+az2.^2))./cos(theta2));
phi3 = acos((ay3./sqrt(ax3.^2+ay3.^2+az3.^2))./cos(theta3));
phi4 = acos((ay4./sqrt(ax4.^2+ay4.^2+az4.^2))./cos(theta4));
phi5 = acos((ay5./sqrt(ax5.^2+ay5.^2+az5.^2))./cos(theta5));

b_m0 = [mx0 my0 mz0];
b_m1 = [mx1 my1 mz1];
b_m2 = [mx2 my2 mz2];
b_m3 = [mx3 my3 mz3];
b_m4 = [mx4 my4 mz4];
b_m5 = [mx5 my5 mz5];

nx = 19.104/19.105;
ny = 0.205/19.105;

psi0 = zeros(ns,1); psi1 = psi0; psi2 = psi0; psi3 = psi0;
psi4 = psi0; psi5 = psi0;

for i = 1:ns
    r0 = [1 0 0; 0 cos(phi0(i)) sin(phi0(i)); 0 -sin(phi0(i)) cos(phi0(i))]...
        *[cos(theta0(i)) 0 -sin(theta0(i)); 0 1 0; sin(theta0(i)) 0 cos(theta0(i))]...
        /(mx0(i)^2+mz0(i)^2);
    r1 = [1 0 0; 0 cos(phi1(i)) sin(phi1(i)); 0 -sin(phi1(i)) cos(phi1(i))]...
        *[cos(theta1(i)) 0 -sin(theta1(i)); 0 1 0; sin(theta1(i)) 0 cos(theta1(i))]...
        /(mx1(i)^2+mz1(i)^2);
    r2 = [1 0 0; 0 cos(phi2(i)) sin(phi2(i)); 0 -sin(phi2(i)) cos(phi2(i))]...
        *[cos(theta2(i)) 0 -sin(theta2(i)); 0 1 0; sin(theta2(i)) 0 cos(theta2(i))]...
        /(mx2(i)^2+mz2(i)^2);
    r3 = [1 0 0; 0 cos(phi3(i)) sin(phi3(i)); 0 -sin(phi3(i)) cos(phi3(i))]...
        *[cos(theta3(i)) 0 -sin(theta3(i)); 0 1 0; sin(theta3(i)) 0 cos(theta3(i))]...
        /(mx3(i)^2+mz3(i)^2);
    r4 = [1 0 0; 0 cos(phi4(i)) sin(phi4(i)); 0 -sin(phi4(i)) cos(phi4(i))]...
        *[cos(theta4(i)) 0 -sin(theta4(i)); 0 1 0; sin(theta4(i)) 0 cos(theta4(i))]...
        /(mx4(i)^2+mz4(i)^2);
    r5 = [1 0 0; 0 cos(phi5(i)) sin(phi5(i)); 0 -sin(phi5(i)) cos(phi5(i))]...
        *[cos(theta5(i)) 0 -sin(theta5(i)); 0 1 0; sin(theta5(i)) 0 cos(theta5(i))]...
        /(mx5(i)^2+mz5(i)^2);
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

figure
plot(time,theta0,'.',time,theta1,'.',time,theta2,'.')
hold on
plot(time,theta3,'.',time,theta4,'.',time,theta5,'.')
ylabel('theta')

figure
plot(time,phi0,'.',time,phi1,'.',time,phi2,'.')
hold on
plot(time,phi3,'.',time,phi4,'.',time,phi5,'.')
ylabel('phi')

figure
plot(time,psi0,'.',time,psi1,'.',time,psi2,'.')
hold on
plot(time,psi3,'.',time,psi4,'.',time,psi5,'.')
ylabel('psi')

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

figure
plot(time,dtheta0,'.',time,dtheta1,'.',time,dtheta2,'.')
hold on
plot(time,dtheta3,'.',time,dtheta4,'.',time,dtheta5,'.')
ylabel('dtheta')

figure
plot(time,dphi0,'.',time,dphi1,'.',time,dphi2,'.')
hold on
plot(time,dphi3,'.',time,dphi4,'.',time,dphi5,'.')
ylabel('dphi')

figure
plot(time,dpsi0,'.',time,dpsi1,'.',time,dpsi2,'.')
hold on
plot(time,dpsi3,'.',time,dpsi4,'.',time,dpsi5,'.')
ylabel('dpsi')

Mth = [dtheta0 dtheta1 dtheta2 dtheta3 dtheta4 dtheta5];
Mps = [dpsi0 dpsi1 dpsi2 dpsi3 dpsi4 dpsi5];
Mph = [dphi0 dphi1 dphi2 dphi3 dphi4 dphi5];

% quaternions
qe0 = zeros(ns,4); qe1 = qe0; qe2 = qe0; qe3 = qe0;
qe4 = qe0; qe5 = qe0; qr0 = qe0; qr1 = qe0; qr2 = qr0;
qr3 = qr0; qr4 = qr0; qr5 = qr0; qa0 = qe0; qa1 = qe0;
qa2 = qa0; qa3 = qa0; qa4 = qa0; qa5 = qa0; q0 = qe0;
q1 = q0; q2 = q0; q3 = q0; q4 = q0; q5 = q0; qt0 = q0;
qt1 = q0; qt2 = q0; qt3 = q0; qt4 = q0; qt5 = q0;
rx1 = zeros(ns,1); ry1 = rx1; rz1 = rx1; rx2 = rx1; ry2 = rx1; rz2 = rx1;
rx3 = rx1; ry3 = rx1; rz3 = rx1; rx4 = rx1; ry4 = rx1; rz4 = rx1;
rx5 = rx1; ry5 = rx1; rz5 = rx1;

for i = 1:ns
    sth = az0(i)/sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2);
    cth = sqrt(1-sth^2);
    qe0(i,:) = [sqrt(.5*(1+cth)) 0 sign(sth)*sqrt(.5*(1-cth)) 0];
    sph = ax0(i)/(cth*sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2));
    cph = ay0(i)/(cth*sqrt(ax0(i)^2 + ay0(i)^2 + az0(i)^2));
    qr0(i,:) = [sqrt(.5*(1+cph)) sign(sph)*sqrt(.5*(1-cph)) 0 0];
    qb0 = [0 b_m0(i,:)];
    e_m = q_quot(qb0,qr0(i,:));
    e_m = q_prod(qe0(i,:),q_prod(qr0(i,:),q_quot(e_m,qe0(i,:))));
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
    qb1 = [0 b_m1(i,:)];
    e_m = q_quot(qb1,qr1(i,:));
    e_m = q_prod(qe1(i,:),q_prod(qr1(i,:),q_quot(e_m,qe1(i,:))));
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
    qb2 = [0 b_m2(i,:)];
    e_m = q_quot(qb2,qr2(i,:));
    e_m = q_prod(qe2(i,:),q_prod(qr2(i,:),q_quot(e_m,qe2(i,:))));
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
    qb3 = [0 b_m3(i,:)];
    e_m = q_quot(qb3,qr3(i,:));
    e_m = q_prod(qe3(i,:),q_prod(qr3(i,:),q_quot(e_m,qe3(i,:))));
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
    qb4 = [0 b_m4(i,:)];
    e_m = q_quot(qb4,qr4(i,:));
    e_m = q_prod(qe4(i,:),q_prod(qr4(i,:),q_quot(e_m,qe4(i,:))));
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
    qb5 = [0 b_m5(i,:)];
    e_m = q_quot(qb5,qr5(i,:));
    e_m = q_prod(qe5(i,:),q_prod(qr5(i,:),q_quot(e_m,qe5(i,:))));
    M_e = [e_m(1) e_m(2)]/sqrt(e_m(1)^2 + e_m(2)^2);
    cps = nx*M_e(1) + ny*M_e(2);
    sps = ny*M_e(1) - nx*M_e(2);
    qa5(i,:) = [sqrt(.5*(1+cps)) 0 0 sign(sps)*sqrt(.5*(1-cps))];
    
    q0(i,:) = q_prod(qa0(i,:),q_prod(qe0(i,:),qr0(i,:)));
    q1(i,:) = q_prod(qa1(i,:),q_prod(qe1(i,:),qr1(i,:)));
    q2(i,:) = q_prod(qa2(i,:),q_prod(qe2(i,:),qr2(i,:)));
    q3(i,:) = q_prod(qa3(i,:),q_prod(qe3(i,:),qr3(i,:)));
    q4(i,:) = q_prod(qa4(i,:),q_prod(qe4(i,:),qr4(i,:)));
    q5(i,:) = q_prod(qa5(i,:),q_prod(qe5(i,:),qr5(i,:)));
    
    qt0(i,:) = q_quot(q0(i,:),q0(i,:));
    qt1(i,:) = q_quot(q1(i,:),q0(i,:));
    qt2(i,:) = q_quot(q2(i,:),q0(i,:));
    qt3(i,:) = q_quot(q3(i,:),q0(i,:));
    qt4(i,:) = q_quot(q4(i,:),q0(i,:));
    qt5(i,:) = q_quot(q5(i,:),q0(i,:));
    
    [rx1(i),ry1(i),rz1(i)] = q2euler(qt1(i,:));
    [rx2(i),ry2(i),rz2(i)] = q2euler(qt2(i,:));
    [rx3(i),ry3(i),rz3(i)] = q2euler(qt3(i,:));
    [rx4(i),ry4(i),rz4(i)] = q2euler(qt4(i,:));
    [rx5(i),ry5(i),rz5(i)] = q2euler(qt5(i,:));
end