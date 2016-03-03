function data = tripodmap3(filename,newfile)
% Allows user to select data and assign to target x,y, and z angles
% Saves selected data to newfile

[time,Gqw,Gqx,Gqy,Gqz,Lqw,Lqx,Lqy,Lqz,rx,ry,rz,lx,ly,lz,ax,ay,az,...
    mx,my,mz,gx,gy,gz,~] = importusb(filename);

%convert Euler angles into degrees
rx = rx*180/pi; ry = ry*180/pi; rz = rz*180/pi;

figure;
plot(time,rx,'b-',time,ry,'r-',time,rz,'g-')
title(filename)
ylabel('Euler angles, deg')
legend('rx','ry','rz')

more = 'y';
olddata = [];

while more=='y'
    display('Select start and end time')
    [t,~] = ginput(2);
    n1 = find(t(1)-0.005 < time & time < t(1)+0.005);
    n2 = find(t(2)-0.005 < time & time < t(2)+0.005);
    n = n2-n1+1;
    newdata = zeros(n,27);
    tx = input('Enter target angles in degrees: x = ');
    ty = input('y = ');
    tz = input('z = ');
    for i = 1:n
        j = n1+i-1;
        newdata(i,:) = [tx ty tz time(j) Gqw(j) Gqx(j) Gqy(j) Gqz(j)...
            Lqw(j) Lqx(j) Lqy(j) Lqz(j) rx(j) ry(j) rz(j) lx(j) ly(j)...
            lz(j) ax(j) ay(j) az(j) mx(j) my(j) mz(j) gx(j) gy(j) gz(j)];
    end
    more = input('More data to add? (y/n) ','s');
    data = [olddata; newdata];
    olddata = data;
end

if(nargin == 2)
    dlmwrite(newfile,data);
end