function data = tablechopQ(filename,newfile)
% Allows user to select data and assign to target quaternions
% Saves selected data to newfile

[time,Gqw1,Gqx1,Gqy1,Gqz1,Lqw1,Lqx1,Lqy1,Lqz1,rx1,ry1,rz1,lx1,ly1,...
    lz1,ax1,ay1,az1,mx1,my1,mz1,gx1,gy1,gz1,~,Gqw2,Gqx2,Gqy2,Gqz2,...
    Lqw2,Lqx2,Lqy2,Lqz2,rx2,ry2,rz2,lx2,ly2,lz2,ax2,ay2,az2,mx2,...
    my2,mz2,gx2,gy2,gz2,~,Gqw3,Gqx3,Gqy3,Gqz3,Lqw3,Lqx3,Lqy3,Lqz3,rx3,...
    ry3,rz3,lx3,ly3,lz3,ax3,ay3,az3,mx3,my3,mz3,gx3,gy3,gz3,~,...
    Gqw4,Gqx4,Gqy4,Gqz4,Lqw4,Lqx4,Lqy4,Lqz4,rx4,ry4,rz4,lx4,ly4,lz4,...
    ax4,ay4,az4,mx4,my4,mz4,gx4,gy4,gz4,~,Gqw5,Gqx5,Gqy5,Gqz5,Lqw5,...
    Lqx5,Lqy5,Lqz5,rx5,ry5,rz5,lx5,ly5,lz5,ax5,ay5,az5,mx5,my5,...
    mz5,gx5,gy5,gz5,~] = importwific(filename);

setup = 0;
while setup == 0
setup = input('Enter setup number (1-4): ');
if setup == 1
    q1 = [1 0 0 0]; q2 = [1 0 0 0]; q3 = [0 0 1 0];
    q4 = [-1/sqrt(2) 0 1/sqrt(2) 0]; q5 = [1/sqrt(2) 0 1/sqrt(2) 0];
elseif setup == 2
    q1 = [1 0 0 0]; q2 = [0 -1 0 0]; q3 = [0 0 1 0];
    q4 = [-1/sqrt(2) 0 1/sqrt(2) 0]; q5 = [1/sqrt(2) 0 1/sqrt(2) 0];
elseif setup == 3
    q1 = [1 0 0 0]; q2 = [0 -1 0 0]; q3 = [0 0 1 0];
    q4 = [-1/sqrt(2) 0 1/sqrt(2) 0]; q5 = [1/sqrt(2) 0 0 1/sqrt(2)];
elseif setup == 4
    q1 = [-.5 -.5 .5 -.5]; q2 = [0 -1 0 0]; q3 = [0 0 1 0];
    q4 = [-1/sqrt(2) 0 1/sqrt(2) 0]; q5 = [1/sqrt(2) 0 0 1/sqrt(2)];
else
    display('Please enter either 1, 2, 3 or 4. ')
    setup = 0;
end
end    

figure;
plot(time,Gqw1,'k-',time,Gqx1,'b-',time,Gqy1,'r-',time,Gqz1,'g-')
title(filename)
ylabel('Global quaternions')
legend('Gqw1','Gqx1','Gqy1','Gqz1')

more = 'y';
olddata = [];
target = [q1; q2; q3; q4; q5];

while more=='y'
    display('Select start and end time')
    [t,~] = ginput(2);
    n1 = find(t(1)-0.005 < time & time < t(1)+0.005);
    n2 = find(t(2)-0.005 < time & time < t(2)+0.005);
    n = n2-n1+1;
    newdata = zeros(n,136);
    angle = input('Enter target rotation increment in degrees: ')*pi/180;
    axis = input('Enter target rotation axis [x y z]: ');
    if(axis=='x')
        axis = [1 0 0]; elseif(axis=='y')
        axis = [0 1 0]; elseif(axis=='z')
        axis = [0 0 1];
    end
    q = [cos(angle/2) axis.*sin(angle/2)];
    for i = 1:5
        target(i,:) = q_prod(q,target(i,:));
    end
    for i = 1:n
        j = n1+i-1;
        newdata(i,:) = [time(j) target(1,:) Gqw1(j) Gqx1(j) Gqy1(j)...
            Gqz1(j) Lqw1(j) Lqx1(j) Lqy1(j) Lqz1(j) rx1(j) ry1(j) rz1(j)...
            lx1(j) ly1(j) lz1(j) ax1(j) ay1(j) az1(j) mx1(j) my1(j) ...
            mz1(j) gx1(j) gy1(j) gz1(j) target(2,:) Gqw2(j) Gqx2(j) ...
            Gqy2(j) Gqz2(j) Lqw2(j) Lqx2(j) Lqy2(j) Lqz2(j) rx2(j) ...
            ry2(j) rz2(j) lx2(j) ly2(j) lz2(j) ax2(j) ay2(j) az2(j) ...
            mx2(j) my2(j) mz2(j) gx2(j) gy2(j) gz2(j) target(3,:) Gqw3(j)...
            Gqx3(j) Gqy3(j) Gqz3(j) Lqw3(j) Lqx3(j) Lqy3(j) Lqz3(j) rx3(j)...
            ry3(j) rz3(j) lx3(j) ly3(j) lz3(j) ax3(j) ay3(j) az3(j) mx3(j)...
            my3(j) mz3(j) gx3(j) gy3(j) gz3(j) target(4,:) Gqw4(j) Gqx4(j)...
            Gqy4(j) Gqz4(j) Lqw4(j) Lqx4(j) Lqy4(j) Lqz4(j) rx4(j) ry4(j)...
            rz4(j) lx4(j) ly4(j) lz4(j) ax4(j) ay4(j) az4(j) mx4(j) my4(j)...
            mz4(j) gx4(j) gy4(j) gz4(j) target(5,:) Gqw5(j) Gqx5(j) ...
            Gqy5(j) Gqz5(j) Lqw5(j) Lqx5(j) Lqy5(j) Lqz5(j) rx5(j) ry5(j)...
            rz5(j) lx5(j) ly5(j) lz5(j) ax5(j) ay5(j) az5(j) mx5(j) my5(j)...
            mz5(j) gx5(j) gy5(j) gz5(j)];
    end
    more = input('More data to add? (y/n) ','s');
    data = [olddata; newdata];
    olddata = data;
end

if(nargin == 2)
    dlmwrite(newfile,data);
end