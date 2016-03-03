function agm2meas(filename)
% converts accelerometer/gyroscope/magnetometer data to measurement vector
% for Kalman filter
% Based on Li, Rocha, Martinez (2011)

data = dlmread(filename,',',1,0);

% create output file and write header
n = length(filename);
outfile = [filename(1:n-4) '-msmt.csv'];
fid = fopen(outfile,'w');
fprintf(fid,'%20s','wx,wy,wz,q0,q1,q2,q3');
fclose(fid);

[n,~] = size(data);
X = zeros(n,7);
singularity = 0;

for i = 1:n
    acc = [data(i,16) data(i,18) data(i,17)];
    mag = [data(i,19) data(i,21) data(i,20)];
    gyro = [-data(i,22) -data(i,24) -data(i,23)];

    if i == 1
        mag0 = mag;
        eMag0 = mag0;
        eMag0(3) = 0;
        eMag0 = eMag0/norm(eMag0);
    end

    % implement factored quaternion algorithm (Yun, Bachmann & McGhee (2008))
    accN = acc/norm(acc);   % normalize acceleration
    
    % check initial (roll) angle
    s = accN(2);
    c = sqrt(1 - s^2);
    
    if c < 0.1
        singularity = 1;
        warning('Singularity condition')
        % offset frame by 20 degrees to get rid of singularity
        qAlpha = [cos(pi/18) sin(pi/18) 0 0];
        % shift home frame
        accN = vq(qAlpha,accN);
        mag = vq(qAlpha,mag);
        mag0 = vq(qAlpha,mag0);
    end
    
    % roll
    qRoll = [sqrt((1+c)/2) sign(s)*sqrt((1-c)/2) 0 0];
    % correct any initial offset in roll
    if i == 1
        qRollOffset = 2*[qRoll(1) 0 0 0] - qRoll;
    end
    qRoll = q_prod(qRollOffset,qRoll);
    
    % pitch
    s = -accN(1)/c;     % ax = -sin(theta)*cos(phi)
    c = accN(3)/c;      % az = cos(theta)*cos(phi)
    qPitch = [sqrt((1+c)/2) 0 sign(s)*sqrt((1-c)/2) 0];
    % correct any initial offset in pitch
    if i==1
        qPitchOffset = 2*[qPitch(1) 0 0 0] - qPitch;
    end
    qPitch = q_prod(qPitchOffset,qPitch);
    
    % yaw (earth frame)
    eMag = vq(q_prod(qPitch,qRoll),mag);
    eMag(3) = 0;
    eMag = eMag/norm(eMag);
    
    c = eMag*eMag0';
    s = -eMag(2)*eMag0(1) + eMag(1)*eMag0(2);
    
    % to avoid strange NaN behavior in s when c is very close to 1 this
    % method does not specify the direction of s
    if abs(c-1) < 1e-6
        qYaw = [1 0 0 0];
    else
        qYaw = [sqrt((1+c)/2) 0 0 sign(s)*sqrt((1-c)/2)];
    end
    % correct any initial offset in yaw
    if i==1
        qYaw = qYaw/norm(qYaw);
        qYawOffset = 2*[qYaw(1) 0 0 0] - qYaw;
    end
    qYaw = q_prod(qYawOffset,qYaw);
    
    % net quaternion
    qSens = q_prod(q_prod(qYaw,qPitch),qRoll);
    
    if (singularity == 1)
        qSens = q_prod(qAlpha,qSens);   % revert quaternion to original frame
        inv_qAlpha = [qAlpha(1) -qAlpha(2) -qAlpha(3) -qAlpha(4)];
        accN = vq(inv_qAlpha,accN);
        mag = vq(inv_qAlpha,mag);
    end
    
    % corresponding Euler angles
%     ESens = QtoE(qSens);
    
    % KF measurement vector
    X(i,:) = [gyro qSens];
end

dlmwrite(outfile,' ','-append');
dlmwrite(outfile,X,'-append');
end

function vout = QtoE(q)
% converts quaternion to Euler angles using the roll/pitch/yaw sequence
x = atan2(2*(q(1)*q(2) + q(3)*q(4)),1 - 2*(q(2)*q(2) + q(3)*q(3)));
y = asin(2*(q(1)*q(3) - q(2)*q(4)));
z = atan2(2*(q(1)*q(4) + q(2)*q(3)),1 - 2*(q(3)*q(3) + q(4)*q(4)));
vout = [x y z];
end
