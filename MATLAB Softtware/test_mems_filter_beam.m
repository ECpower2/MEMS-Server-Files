function test_mems_filter_beam(filename)
% implements discrete-time extended Kalman filter for MEMS, based on Li, 
% Rocha & Martinez (2011)

% NOTE coordinate systems: 
% mn = motion node (+x = north, +y = up, +z = east)
% ned = north-east-down (+x = north, +y = east, +z = down)

dt = 0.01;  % sampling rate = 100 Hz
n_state = 7;    % number of state variables
n_msmt = 7;     % number of measurement variables

data = dlmread(filename,',',1,0);
% data = data(1:100,:);     % TEST ONLY *truncate file for speed*
[n,c] = size(data);
n_nodes = floor(c/25);

% get column headers
fid = fopen(filename);
tline = fgetl(fid);
cols = strsplit(tline,',');

for j = 1:n_nodes
    % identify node
    c0 = 25*(j-1) + 1;
    nodeID = str2double(cols{c0}(5:6));
    if strcmp(cols{c0}(1:3),'Mot') == 1
        nodeID = 0;
    end
    
    % create post-process file
    name = length(filename);
    if n_nodes == 1
        csv_complete = [filename(1:name-4) '-complete-post-process.csv'];
    else
        csv_complete = [filename(1:name-4) '-node' num2str(nodeID) ...
            '-complete-post-process.csv'];
    end
    fid = fopen(csv_complete,'w');
    header = ['time,EqKm_x,EqKm_y,EqKm_z,QTx_x,QTx_y,QTx_z,'...
        'EKin_x,EKin_y,EKin_z,QKin_x,QKin_y,QKin_z,'...
        'Sens_x,Sens_y,Sens_z,'...
        'a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,'...
        'Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,'...
        'J'];
    fprintf(fid,'%189s',header);
    fclose(fid);
    dlmwrite(csv_complete,' ','-append');
    
    % initialize variables (at t = n and n-1)
    EKin = zeros(1,3); EKin_n1 = EKin;
    accBias = zeros(1,3); magBias = accBias;
    
    % Kalman filter preparation
    x_post = zeros(n_state,1);      % initial state estimate
    x_post(4) = 1/sqrt(2); x_post(5) = 1/sqrt(2);     % ned = [1 0 0 0] mn
    P_post = 0.1*ones(n_state,n_state); % initial process error covariance
    Q = zeros(n_state);     % process noise covariance matrix
    Q(1,1) = 0.4*(1-exp(-2*dt/.5));
    Q(2,2) = 0.4*(1-exp(-2*dt/.5));
    Q(3,3) = 0.4*(1-exp(-2*dt/.5));
    R = zeros(n_msmt);       % noise covariance matrix
    R(1,1) = 0.01;
    R(2,2) = 0.01;
    R(3,3) = 0.01;
    R(4,4) = 0.0001;
    R(5,5) = 0.0001;
    R(6,6) = 0.0001;
    R(7,7) = 0.0001;
    
    % t = 0
    % acc_n1 = data(1,c0+15:c0+17) - accBias;
    % mag_n1 = data(1,c0+18:c0+20) - magBias;
    gyro_n1 = [data(1,c0+21) data(1,c0+23) -data(1,c0+22)]*pi/180;   % ned
    qG0 = data(1,c0+1:c0+4);                                           % mn
    qKin_n1 = [1 0 0 0];
    
    % iterate over each row in data file
    for i = 2:n
        %     display(['i = ',num2str(i)])
        time = data(i,c0);
        acc = data(i,c0+15:c0+17) - accBias;                         % mn
        mag = data(i,c0+18:c0+20) - magBias;                         % mn
        gyro = [data(i,c0+21) data(i,c0+23) -data(i,c0+22)]*pi/180;  % ned
        qG = data(i,c0+1:c0+4);                                        % mn
        qTx = q_quot(qG,qG0);                                        % mn
        [EqTxx,EqTxy,EqTxz] = q2euler(qTx);
        EqTx = [EqTxx EqTxy EqTxz];                                  % mn
        % convert to NED frame
        %     EqTx = [EqTxx EqTxz -EqTxy];                           % ned
        
        % quaternion kinematic equation: q(n) = q_np.dot(n-1)*dt + q(n-1)
        % q(n) = (q(n-1)*w(n-1))*dt/2 + q(n-1)
        qKin = q_prod(qKin_n1,[0 gyro_n1])*dt/2 + qKin_n1;      % ned
        
        % time shift: n = n-1
        qKin_n1 = qKin;                                         % ned
        %     qKin = q_prod(qKin,[1/sqrt(2) -1/sqrt(2) 0 0]);         % mn
        qKin = [qKin(1) qKin(2) -qKin(4) qKin(3)];              % mn
        
        % convert to Euler angles
        [Eqkx,Eqky,Eqkz] = q2euler(qKin);
        EqKin = [Eqkx Eqky Eqkz];                               % mn
        
        % Euler  angle kinematic equation
        % d_phi = p + sin(phi)*tan(theta)*q + cos(phi)*tan(theta)*r
        EKin(1) = gyro_n1(1) + sin(EKin_n1(1))*tan(EKin_n1(2))*gyro_n1(2) ...
            + cos(EKin_n1(1))*tan(EKin_n1(2))*gyro_n1(3);
        % d_theta = cos(phi)*q - sin(phi)*r
        EKin(2) = cos(EKin_n1(1))*gyro_n1(2) - sin(EKin_n1(1))*gyro_n1(3);
        % d_psi = sin(phi)*q/cos(theta) + cos(phi)*r/cos(theta);
        EKin(3) = sin(EKin_n1(1))*gyro_n1(2)/cos(EKin_n1(2)) ...
            + cos(EKin_n1(1))*gyro_n1(3)/cos(EKin_n1(2));
        EKin = EKin_n1 + EKin*dt;                               % ned
        
        % FQA
        qSens = fqa(acc(1),acc(2),acc(3),mag(1),mag(2),mag(3)); % mn
        [ESensx,ESensy,ESensz] = q2euler(qSens);
        ESens = [ESensx ESensy ESensz];                         % mn
        
        % discrete-time extended Kalman filter
        % project state ahead using Runge-Kutta 4th order integration scheme
        k1 = dt*KF_eval_state_f(x_post);
        k2 = dt*KF_eval_state_f(x_post + 0.5*k1);
        k3 = dt*KF_eval_state_f(x_post + 0.5*k2);
        k4 = dt*KF_eval_state_f(x_post + k3);
        x_priori = x_post + (k1 + 2*k2 + 2*k3 + k4)/6;
        
        % project state error covariance ahead
        A = [-2 0 0 0 0 0 0; 0 -2 0 0 0 0 0; 0 0 -2 0 0 0 0;...
            -.5*x_post(5) -.5*x_post(6) -.5*x_post(7) 0 -.5*x_post(1)...
            -.5*x_post(2) -.5*x_post(3);...
            .5*x_post(4) -.5*x_post(7) .5*x_post(6) .5*x_post(1) 0 ...
            .5*x_post(3) -.5*x_post(2);...
            .5*x_post(7) .5*x_post(4) -.5*x_post(5) .5*x_post(2) ...
            -.5*x_post(3) 0 .5*x_post(1);...
            -.5*x_post(6) .5*x_post(5) .5*x_post(4) .5*x_post(3) ...
            .5*x_post(2) -.5*x_post(1) 0];
        A = dt*A + eye(n_state);
        %     P_priori = dot(A,dot(P_post,A.')) + Q;
        P_priori = A*P_post*A.' + Q;
        
        % read measurement
        z = [gyro q_prod(qSens,[1/sqrt(2) 1/sqrt(2) 0 0])];     % ned
        
        % measurement update (correction step)
        % evaluate the linearized measurement matrix
        H = eye(n_msmt,n_state);
        % compute the Kalman gain
        S = H*P_priori*H.' + R;
        K = P_priori*H.'/S;
        % update estimate with measurement z,k
        x_post = x_priori + K*(z' - H*x_priori);                % ned
        % update error covariance P,k|k
        P_post = (eye(n_state) - K*H)*P_priori;
        
        % Cost function J = trace(P,k|k)
        J = trace(P_post);
        
        % grab data from Kalman filter
        wKalman = [x_post(1) -x_post(3) x_post(2)];             % mn
        qKalman = q_prod(x_post(4:7),[1/sqrt(2) -1/sqrt(2) 0 0]); % mn
        [EqKx,EqKy,EqKz] = q2euler(qKalman);
        EqKalman = [EqKx EqKy EqKz];                            % mn
        
        % linear acceleration
        %     lacc = vq(qKalman,acc);
        
        % time update
        EKin_n1 = EKin;
        EKin = [EKin(1) -EKin(3) EKin(2)];                      % mn
        %     acc_n1 = acc;
        gyro_n1 = gyro;
        gyro = [gyro(1) -gyro(3) gyro(2)];                      % mn
        
        % write to output file
        data_complete = [time EqKalman EqTx EKin EqKin ESens acc mag gyro ...
            wKalman qKalman J];
        dlmwrite(csv_complete,data_complete,'-append');
    end
end
end

function xDot = KF_eval_state_f(x)
xDot = [-x(1)/.5; -x(2)/.5; -x(3)/.5; ...
    -.5*(x(1)*x(5) + x(2)*x(6) + x(3)*x(7));...
    .5*(x(1)*x(4) + x(3)*x(6) - x(2)*x(7)); ...
    .5*(x(1)*x(7) + x(2)*x(4) - x(3)*x(5)); ...
    .5*(x(2)*x(5) + x(3)*x(4) - x(1)*x(6))];
end