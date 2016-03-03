function [angles] = getQangles(file,ref)
% Return angle of rotation with respect to reference quaternion (ref)
% 
% file = MotionNode take_stream output in csv format

data = importdata(file,',',1);
Gqw = data.data(:,2);
Gqx = data.data(:,3);
Gqy = data.data(:,4);
Gqz = data.data(:,5);
[n,~] = size(Gqz);

angles = zeros([n 4]);

if length(ref) == 4
    for i=1:n
        % calculate Gq/ref
        qr1 = Gqw(i)*ref(1)+Gqx(i)*ref(2)+Gqy(i)*ref(3)+Gqz(i)*ref(4);
        qr2 = -Gqw(i)*ref(2)+Gqx(i)*ref(1)-Gqy(i)*ref(4)+Gqz(i)*ref(3);
        qr3 = -Gqw(i)*ref(3)+Gqx(i)*ref(4)+Gqy(i)*ref(1)-Gqz(i)*ref(2);
        qr4 = -Gqw(i)*ref(4)-Gqx(i)*ref(3)+Gqy(i)*ref(2)+Gqz(i)*ref(1);
        % find rotation angles and vectors
        angles(i,1) = 2*acos(qr1);
        angles(i,2) = qr2/sin(angles(i,1));
        angles(i,3) = qr3/sin(angles(i,1));
        angles(i,4) = qr4/sin(angles(i,1));
    end
else
    error('reference quaternion (ref) is not a vector of length 4')
end