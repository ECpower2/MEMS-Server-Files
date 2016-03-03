function outfile = mems_Kalman_postprocess2(filename,nref)
% adjusted for optimal output of sensors 1 and 2
% implements discrete-time extended Kalman filter for MEMS, based on Li,
% Rocha & Martinez (2011)

% NOTE coordinate systems:
% mn = motion node (+x = west, +y = up, +z = north)
% ned = north-east-down (+x = north, +y = east, +z = down)

% current magnetic field at test location
display('Note: for best accuracy, update Earth magnetic field values ');
display('in fqa.m (line 10) for test location and date at ');
display('http://www.ngdc.noaa.gov/geomag-web/#igrfwmm');

data = dlmread(filename,',',1,0);
% data = data(1:100,:);     % TEST ONLY *truncate file for speed*
[n,c] = size(data);
n_nodes = floor(c/25);

% get reference node number if not specified
if nargin < 2
    nref = input('Enter reference node number: ');
end

% get column headers
fid = fopen(filename);
tline = fgetl(fid);
cols = strsplit(tline,',');

% determine orientation of reference node
for j = 1:n_nodes
    % identify node
    c0 = 25*(j-1) + 1;
    nodeID = str2double(cols{c0}(5:6));
    if strcmp(cols{c0}(1:3),'Mot') == 1
        nodeID = 0;
    end
    
    if nodeID == nref
        % create post-process file
        name = length(filename);
        csv_ref = [filename(1:name-4) '-ref.csv'];
        fid = fopen(csv_ref,'w');
        header = ['time,EqKm_x,EqKm_y,EqKm_z,Sens_x,Sens_y,Sens_z,'...
            'a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,'...
            'Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z'];
        fprintf(fid,'%128s',header);
        fclose(fid);
        dlmwrite(csv_ref,' ','-append');
        
        [time,qSens_ref,acc,mag,gyro,wKalman,qKal_ref,~] ...
            = KF_node(n,c0,data);
        ESens_ref = q2eulerN(qSens_ref);                  % ned
        EqKal_ref =  q2eulerN(qKal_ref);                  % ned
        
        % write to output file
        data_complete = [time EqKal_ref ESens_ref acc mag gyro...
            wKalman qKal_ref];
        dlmwrite(csv_ref,data_complete,'-append');
    end
end

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
        outfile = [filename(1:name-4) '-post-process.csv'];
    else
        outfile = [filename(1:name-4) '-node' num2str(nodeID) ...
            '-post-process.csv'];
    end
    fid = fopen(outfile,'w');
    header = ['time,EqKm_x,EqKm_y,EqKm_z,Sens_x,Sens_y,Sens_z,'...
        'a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,'...
        'Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,J'];
    fprintf(fid,'%129s',header);
    fclose(fid);
    dlmwrite(outfile,' ','-append');
    
    [time,qSens,acc,mag,gyro,wKalman,qKalman,J] = KF_node(n,c0,data);
        
    if nodeID == 7
        dtemp = q_quot(qSens(1,:),qSens_ref(1,:));
        ESens = q2eulerN(q_quotN(q_quotN(qSens,qSens_ref),dtemp));
        dtemp = q_quot(qKalman(2,:),qKal_ref(2,:));
        qKalman = q_quotN(qKalman,dtemp);
        EqKalman = q2eulerN(qKalman);
    elseif nodeID == 2
        ESens = q2eulerN(qSens);
        EqKalman = q2eulerN(qKalman);
    else
        ESens = q2eulerN(q_quotN(qSens,qSens_ref));                 % ned
        qKalman = q_quotN(qKalman,qKal_ref);                        % ned
        EqKalman = q2eulerN(qKalman);                               % ned
    end
    
    % write to output file
    data_complete = [time EqKalman ESens acc mag gyro wKalman qKalman J];
    dlmwrite(outfile,data_complete,'-append');
end
end

function [time,qSens,acc,mag,gyro,wKalman,qKalman,J] = KF_node(n,c0,data)
dt = 0.01;  % sampling rate = 100 Hz
n_state = 7;    % number of state variables
n_msmt = 7;     % number of measurement variables
% initialize variables
accBias = zeros(n,3); magBias = accBias;
qSens = zeros(n,4); wKalman = zeros(n,3); qKalman = qSens; J = zeros(n,1);

% Kalman filter preparation
x_post = zeros(n_state,1);      % initial state estimate
x_post(4) = 1;
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

% read data
time = data(:,c0);
acc = data(:,c0+15:c0+17) - accBias;                         % mn
mag = data(:,c0+18:c0+20) - magBias;                         % mn
gyro = [data(:,c0+23) -data(:,c0+21) -data(:,c0+22)]*pi/180; % ned

% check for excess magnetic interference and apply correction
% if any(any(mag > 99.9)) || any(any(mag < -99.9))
%     display('Magnetic field limits reached. Applying correction.')
%     for i=1:n
%         if abs(mag(i,1)) > 99
%             mag(i,1) = sqrt(48.973^2 - mag(i,2)^2 - mag(i,3)^2);
%         elseif abs(mag(i,2)) > 99
%             mag(i,2) = sqrt(48.973^2 - mag(i,1)^2 - mag(i,3)^2);
%         elseif abs(mag(i,3)) > 99
%             mag(i,3) = sqrt(48.973^2 - mag(i,1)^2 - mag(i,2)^2);
%         end
%     end
% end    

% FQA
qSens = fqa(acc(:,3),-acc(:,1),-acc(:,2),mag(:,3),-mag(:,1),-mag(:,2)); % ned
    
% iterate over each row in data file
for i = 2:n
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
    z = [gyro(i,:) qSens(i,:)];
    
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
    J(i) = trace(P_post);
    
    % grab data from Kalman filter
    wKalman(i,:) = x_post(1:3)';                                % ned
    qKalman(i,:) = x_post(4:7)';                                % ned
end
end

function xDot = KF_eval_state_f(x)
xDot = [-x(1)/.5; -x(2)/.5; -x(3)/.5; ...
    -.5*(x(1)*x(5) + x(2)*x(6) + x(3)*x(7));...
    .5*(x(1)*x(4) + x(3)*x(6) - x(2)*x(7)); ...
    .5*(x(1)*x(7) + x(2)*x(4) - x(3)*x(5)); ...
    .5*(x(2)*x(5) + x(3)*x(4) - x(1)*x(6))];
end