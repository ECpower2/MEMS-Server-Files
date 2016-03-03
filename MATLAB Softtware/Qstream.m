function Qout = Qstream(meas_stream,ref_stream)
% Finds quaternion relating measured MotionNode orientation to reference
% orientation, Qout = cos(a/2) + sin(a/2)*v
% a = angle of rotation, v = vector about which rotation takes place
% Qout = [cos(a/2) sin(a/2)*vx sin(a/2)*vy sin(a/2)*vz]

meas = importdata(meas_stream,',',1);
ref = importdata(ref_stream,',',1);
M = meas.data(:,2:5);    % select global quaternion data from columns 2-5
R = ref.data(:,2:5);

if length(M)>length(R)
    n = length(R);
else
    n = length(M);
end

Qout = zeros(n,4);

for i=1:n
        % calculate M/R
        q1 = M(i,1)*R(i,1)+M(i,2)*R(i,2)+M(i,3)*R(i,3)+M(i,4)*R(i,4);
        q2 = -M(i,1)*R(i,2)+M(i,2)*R(i,1)-M(i,3)*R(i,4)+M(i,4)*R(i,3);
        q3 = -M(i,1)*R(i,3)+M(i,2)*R(i,4)+M(i,3)*R(i,1)-M(i,4)*R(i,2);
        q4 = -M(i,1)*R(i,4)-M(i,2)*R(i,3)+M(i,3)*R(i,2)+M(i,4)*R(i,1);
        Qout(i,:) = [q1 q2 q3 q4];
end