function fliptest()
% takes quaternions to Euler angles to sensors to Euler angles

% define quaternions and plot
t = linspace(0,6*pi,300);
% n1 = (rand(1,100) - .5)/10; n2 = (rand(1,100) - .5)/10; 
% n3 = (rand(1,100) - .5)/10;
n1 = linspace(0,0.2); n2 = linspace(0,0.1); n3 = linspace(0,0.15);
q1 = [sin(t(1:100))/1.4 zeros(1,200)];
q2 = [zeros(1,100) sin(t(101:200))/1.4 zeros(1,100)];
q3 = [zeros(1,200) sin(t(201:300))/1.4];
q1 = q1 + [zeros(1,100) -n2 n3];
q2 = q2 + [n1 zeros(1,100) -n3];
q3 = q3 - [n1 -n2 zeros(1,100)];
q0 = sqrt(1 - q1.*q1 - q2.*q2 - q3.*q3);

figure
plot(t,q0,'k',t,q1,'b',t,q2,'r',t,q3,'g')
xlabel('time'); ylabel('quaternions')

% convert to Euler angles using ZYX sequence
for i = 1:300
    [rx(i),ry(i),rz(i)] = q2euler([q0(i) q1(i) q2(i) q3(i)]); %#ok<AGROW>
end

% calculate sensor readings (Y aligned with gravity, g=1) and plot
ax = 2*(q1.*q2 + q0.*q3);
ay = q0.*q0 - q1.*q1 + q2.*q2 - q3.*q3;
az = 2*(q2.*q3 - q0.*q1);

mx = 19.2457;
my = 44.8002;
mz = 0;
mz = -.918;
Mx = mx*(q0.*q0 + q1.*q1 - q2.*q2 - q3.*q3) + 2*my*(q1.*q2 + q0.*q3) ...
    + 2*mz*(q1.*q3 - q0.*q2);
My = 2*mx*(q1.*q2 - q0.*q3) + my*(q0.*q0 - q1.*q1 + q2.*q2 - q3.*q3) ...
    + 2*mz*(q2.*q3 + q0.*q1);
Mz = 2*mx*(q1.*q3 + q0.*q2) + 2*my*(q2.*q3 - q0.*q1) ...
    + mz*(q0.*q0 - q1.*q1 - q2.*q2 + q3.*q3);

figure
plot(t,ax,'b',t,ay,'r',t,az,'g')
xlabel('time'); ylabel('acceleration')
figure
plot(t,Mx,'b',t,My,'r',t,Mz,'g')
xlabel('time'); ylabel('magnetic field')

% calculate Euler angles from sensor readings
[phi,theta, psi] = mg2euler(Mx,My,Mz,ax,ay,az);

figure
plot(t,rx,'b',t,ry,'r',t,rz,'g',t,phi,'c--',t,theta,'m--',t,psi,'k--')
xlabel('time'); ylabel('Euler angles')