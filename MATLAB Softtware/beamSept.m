import_beamSept

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

for i = 1:42
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
plot(disp1,theta0,'.',disp1,theta1,'.',disp1,theta2,'.')
hold on
plot(disp1,theta3,'.',disp1,theta4,'.',disp1,theta5,'.')
ylabel('theta')

figure
plot(disp1,phi0,'.',disp1,phi1,'.',disp1,phi2,'.')
hold on
plot(disp1,phi3,'.',disp1,phi4,'.',disp1,phi5,'.')
ylabel('phi')

figure
plot(disp1,psi0,'.',disp1,psi1,'.',disp1,psi2,'.')
hold on
plot(disp1,psi3,'.',disp1,psi4,'.',disp1,psi5,'.')
ylabel('psi')

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

theta0 = theta0 - theta0(1);
theta1 = theta1 - theta0 - (theta1(1) - theta0(1));
theta2 = theta2 - theta0 - (theta2(1) - theta0(1));
theta3 = theta3 - theta0 - (theta3(1) - theta0(1));
theta4 = theta4 - theta0 - (theta4(1) - theta0(1));
theta5 = theta5 - theta0 - (theta5(1) - theta0(1));

phi0 = phi0 - phi0(1);
phi1 = phi1 - phi0 - (phi1(1) - phi0(1));
phi2 = phi2 - phi0 - (phi2(1) - phi0(1));
phi3 = phi3 - phi0 - (phi3(1) - phi0(1));
phi4 = phi4 - phi0 - (phi4(1) - phi0(1));
phi5 = phi5 - phi0 - (phi5(1) - phi0(1));

psi0 = psi0 - psi0(1);
psi1 = psi1 - psi0 - (psi1(1) - psi0(1));
psi2 = psi2 - psi0 - (psi2(1) - psi0(1));
psi3 = psi3 - psi0 - (psi3(1) - psi0(1));
psi4 = psi4 - psi0 - (psi4(1) - psi0(1));
psi5 = psi5 - psi0 - (psi5(1) - psi0(1));

figure
plot(disp1,theta0,'.',disp1,theta1,'.',disp1,theta2,'.')
hold on
plot(disp1,theta3,'.',disp1,theta4,'.',disp1,theta5,'.')
ylabel('dtheta')

figure
plot(disp1,phi0,'.',disp1,phi1,'.',disp1,phi2,'.')
hold on
plot(disp1,phi3,'.',disp1,phi4,'.',disp1,phi5,'.')
ylabel('dphi')

figure
plot(disp1,psi0,'.',disp1,psi1,'.',disp1,psi2,'.')
hold on
plot(disp1,psi3,'.',disp1,psi4,'.',disp1,psi5,'.')
ylabel('dpsi')

A = [theta0 theta1 theta2 theta3 theta4 theta5];
A = tan(A);
sensor_loc = [0 .029 .209 .389 .569 .749];

p1 = zeros(42,1); p2 = p1; p3 = p1; rsquare = p1;

for i = 1:42
    [f,gof] = fit(sensor_loc', A(i,:)','poly2');
    p1(i) = f.p1; p2(i) = f.p2; p3(i) = f.p3;
    rsquare(i) = gof.rsquare;
end

Mth = [theta0 theta1 theta2 theta3 theta4 theta5];
Mps = [psi0' psi1' psi2' psi3' psi4' psi5'];
Mph = [phi0 phi1 phi2 phi3 phi4 phi5];
Mf = [p1 p2 p3 rsquare];
M = [Mth Mps Mph Mf];