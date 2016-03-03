function tripoddata(filename)
% plots comparisons of sensor data from Motions

[time,Gqw,Gqx,Gqy,Gqz,Lqw,Lqx,Lqy,Lqz,rx,ry,rz,lx,ly,lz,ax,ay,az,...
    mx,my,mz,gx,gy,gz,~] = importusb(filename);


%convert Euler angles into degrees
rx = rx*180/pi; ry = ry*180/pi; rz = rz*180/pi;

figure;
plot(time,ax,'b-',time,ay,'r-',time,az,'g-')
title(filename)
ylabel('Accelerometers, g')
legend('ax','ay','az')
figure;
plot(time,mx,'b-',time,my,'r-',time,mz,'g-')
title(filename)
ylabel('Magnetometers, uT')
legend('mx','my','mz')
figure;
plot(time,gx,'b-',time,gy,'r-',time,gz,'g-')
title(filename)
ylabel('Gyroscopes, deg/s')
legend('gx','gy','gz')
figure;
plot(time,rx,'b-',time,ry,'r-',time,rz,'g-')
title(filename)
ylabel('Euler angles, deg')
legend('rx','ry','rz')
% figure;
% plot(time,lx,'b-',time,ly,'r--',time,lz,'g-.')
% title(filename)
% ylabel('Linear acceleration, g')
% legend('lx','ly','lz')
figure;
plot(time,Gqw,'k.',time,Gqx,'b-',time,Gqy,'r-',time,Gqz,'g-')
title(filename)
ylabel('Global quaternions')
legend('Gqw','Gqx','Gqy','Gqz')
figure;
plot(time,Lqw,'k.',time,Lqx,'b-',time,Lqy,'r-',time,Lqz,'g-')
title(filename)
ylabel('Local quaternions')
legend('Lqw','Lqx','Lqy','Lqz')
