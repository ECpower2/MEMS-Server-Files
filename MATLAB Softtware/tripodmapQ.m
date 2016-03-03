function data = tripodmapQ(filename,newfile)
% Allows user to select data and assign to target quaternion
% Saves selected data to newfile

[time,Gqw,Gqx,Gqy,Gqz,Lqw,Lqx,Lqy,Lqz,rx,ry,rz,lx,ly,lz,ax,ay,az,...
    mx,my,mz,gx,gy,gz,~] = importusb(filename);

%convert Euler angles into degrees
rx = rx*180/pi; ry = ry*180/pi; rz = rz*180/pi;

figure;
plot(time,rx,'b-',time,ry,'r-',time,rz,'g-')
% plot(time,Gqw,'k-',time,Gqx,'b-',time,Gqy,'r-',time,Gqz,'g-')
title(filename)
ylabel('Euler angles, deg')
legend('rx','ry','rz')

more = 'y';
olddata = [];
target = [1 0 0 0];

while more=='y'
    display('Select start and end time')
    [t,~] = ginput(2);
    n1 = find(t(1)-0.005 < time & time < t(1)+0.005);
    n2 = find(t(2)-0.005 < time & time < t(2)+0.005);
    n = n2-n1+1;
    newdata = zeros(n,30);
    angle = input('Enter target rotation increment in degrees: ')*pi/180;
    axis = input('Enter target rotation axis [x y z]: ');
    if(axis=='x')
        axis = [1 0 0]; elseif(axis=='y')
        axis = [0 1 0]; elseif(axis=='z')
        axis = [0 0 1];
    end
    q = [cos(angle/2) axis.*sin(angle/2)];
    target = q_prod(q,target);
    theta = 2*atan(target(2)/target(1));
    phi = 2*atan(target(3)/target(1));
    for i = 1:n
        j = n1+i-1;
        newdata(i,:) = [target theta phi time(j) Gqw(j) Gqx(j) Gqy(j) Gqz(j)...
            Lqw(j) Lqx(j) Lqy(j) Lqz(j) rx(j) ry(j) rz(j) lx(j) ly(j)...
            lz(j) ax(j) ay(j) az(j) mx(j) my(j) mz(j) gx(j) gy(j) gz(j)];
    end
    more = input('More data to add? (y/n) ','s');
    data = [olddata; newdata];
    olddata = data;
end

if(nargin == 2)
    header = ['tGqw,tGqx,tGqy,tGqz,theta,phi,time,Gqw,Gqx,Gqy,Gqz,Lqw,'...
         'Lqx,Lqy,Lqz,rx,ry,rz,lx,ly,lz,ax,ay,az,mx,my,mz,gx,gy,gz'];
    fid = fopen(newfile,'w');
    fprintf(fid,'%s\r\n',header);
    fclose(fid);
    dlmwrite(newfile,data,'-append');
end