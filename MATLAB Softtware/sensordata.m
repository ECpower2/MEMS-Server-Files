function sensordata(filename)
% plots comparisons of sensor data from Motions

[time,Gqw1,Gqx1,Gqy1,Gqz1,Lqw1,Lqx1,Lqy1,Lqz1,rx1,ry1,rz1,lx1,...
    ly1,lz1,ax1,ay1,az1,mx1,my1,mz1,gx1,gy1,gz1,~,Gqw2,Gqx2,Gqy2,...
    Gqz2,Lqw2,Lqx2,Lqy2,Lqz2,rx2,ry2,rz2,lx2,ly2,lz2,ax2,ay2,az2,...
    mx2,my2,mz2,gx2,gy2,gz2,~,Gqw3,Gqx3,Gqy3,Gqz3,Lqw3,Lqx3,Lqy3,Lqz3,...
    rx3,ry3,rz3,lx3,ly3,lz3,ax3,ay3,az3,mx3,my3,mz3,gx3,gy3,...
    gz3,~,Gqw4,Gqx4,Gqy4,Gqz4,Lqw4,Lqx4,Lqy4,Lqz4,rx4,ry4,rz4,lx4,...
    ly4,lz4,ax4,ay4,az4,mx4,my4,mz4,gx4,gy4,gz4,~,Gqw5,Gqx5,Gqy5,...
    Gqz5,Lqw5,Lqx5,Lqy5,Lqz5,rx5,ry5,rz5,lx5,ly5,lz5,ax5,ay5,az5,...
    mx5,my5,mz5,gx5,gy5,gz5,~] = importwific(filename);

%convert Euler angles into degrees
rx1 = rx1*180/pi; ry1 = ry1*180/pi; rz1 = rz1*180/pi;
rx2 = rx2*180/pi; ry2 = ry2*180/pi; rz2 = rz2*180/pi;
rx3 = rx3*180/pi; ry3 = ry3*180/pi; rz3 = rz3*180/pi;
rx4 = rx4*180/pi; ry4 = ry4*180/pi; rz4 = rz4*180/pi;
rx5 = rx5*180/pi; ry5 = ry5*180/pi; rz5 = rz5*180/pi;

%setup 1
figure;
plot(time,ax1,'g-',time,ax2,'g--',time,ax3,'g:',time,ax4,'c-.',...
    time,ax5,'c-',time,ay1,'r-',time,ay2,'r--',time,ay3,'r:',...
    time,ay4,'m-.',time,ay5,'m-',time,az1,'b-',time,az2,'b--',...
    time,az3,'b:',time,az4,'g-.',time,az5,'g.')
title(filename)
ylabel('Accelerometers, g')
legend('ax1','ax2','ax3','ax4','ax5','ay1','ay2','ay3','ay4','ay5',...
    'az1','az2','az3','az4','az5')
figure;
plot(time,mx1,'g-',time,mx2,'g--',time,mx3,'g:',time,mx4,'c-.',...
    time,mx5,'c-',time,my1,'r-',time,my2,'r--',time,my3,'r:',...
    time,my4,'m-.',time,my5,'m-',time,mz1,'b-',time,mz2,'b--',...
    time,mz3,'b:',time,mz4,'g-.',time,mz5,'g.')
title(filename)
ylabel('Magnetometers, uT')
legend('mx1','mx2','mx3','mx4','mx5','my1','my2','my3','my4','my5',...
    'mz1','mz2','mz3','mz4','mz5')
figure;
plot(time,gx1,'g-',time,gx2,'g--',time,gx3,'g:',time,gx4,'c-.',...
    time,gx5,'c-',time,gy1,'r-',time,gy2,'r--',time,gy3,'r:',...
    time,gy4,'m-.',time,gy5,'m-',time,gz1,'b-',time,gz2,'b--',...
    time,gz3,'b:',time,gz4,'g-.',time,gz5,'g.')
title(filename)
ylabel('Gyroscopes, deg/s')
legend('gx1','gx2','gx3','gx4','gx5','gy1','gy2','gy3','gy4','gy5',...
    'gz1','gz2','gz3','gz4','gz5')
figure;
plot(time,Gqw1,'k-',time,Gqw2,'k--',time,Gqw3,'k:',time,Gqw4,'k-.',...
    time,Gqw5,'k.',time,Gqx1,'g-',time,Gqx2,'g--',time,Gqx3,'g:',...
    time,Gqx4,'c-.',time,Gqx5,'c-',time,Gqy1,'r-',time,Gqy2,'r--',...
    time,Gqy3,'r:',time,Gqy4,'m-.',time,Gqy5,'m-',time,Gqz1,'b-',...
    time,Gqz2,'b--',time,Gqz3,'b:',time,Gqz4,'g-.',time,Gqz5,'g.')
title(filename)
ylabel('Global quaternions')
legend('Gqw1','Gqw2','Gqw3','Gqw4','Gqw5','Gqx1','Gqx2','Gqx3','Gqx4',...
    'Gqx5','Gqy1','Gqy2','Gqy3','Gqy4','Gqy5',...
    'Gqz1','Gqz2','Gqz3','Gqz4','Gqz5')
figure;
plot(time,rx1,'g-',time,rx2,'g--',time,rx3,'g:',time,rx4,'c-.',...
    time,rx5,'c-',time,ry1,'r-',time,ry2,'r--',time,ry3,'r:',...
    time,ry4,'m-.',time,ry5,'m-',time,rz1,'b-',time,rz2,'b--',...
    time,rz3,'b:',time,rz4,'g-.',time,rz5,'g.')
title(filename)
ylabel('Euler angles, deg')
legend('rx1','rx2','rx3','rx4','rx5','ry1','ry2','ry3','ry4','ry5',...
    'rz1','rz2','rz3','rz4','rz5')
