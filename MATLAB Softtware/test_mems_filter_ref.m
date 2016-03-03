function test_mems_filter_ref(filename,refnode)
% implements discrete-time extended Kalman filter for MEMS, based on Li, 
% Rocha & Martinez (2011)
% enter number of node to use as reference for other nodes

% NOTE coordinate systems: 
% mn = motion node (+x = north, +y = up, +z = east)
% ned = north-east-down (+x = north, +y = east, +z = down)

dt = 0.01;  % sampling rate = 100 Hz

data = dlmread(filename,',',1,0);
% data = data(1:100,:);     % TEST ONLY *truncate file for speed*
[n,c] = size(data);
n_nodes = floor((c-1)/24);
x_nodes = zeros(n_nodes,n,7);

% get column headers
fid = fopen(filename);
tline = fgetl(fid);
cols = strsplit(tline,',');

for j = 1:n_nodes
    % identify node
    c0 = 24*(j-1) + 2;
    nodeID = str2double(cols{c0}(5:6));
    
    % create post-process file
    name = length(filename);
    csv_complete = [filename(1:name-4) '-node' num2str(nodeID) ...
        '-complete-post-process.csv'];
    fid = fopen(csv_complete,'w');
    header = ['time,EqKm_x,EqKm_y,EqKm_z,QTx_x,QTx_y,QTx_z,'...
        'EKin_x,EKin_y,EKin_z,QKin_x,QKin_y,QKin_z,'...
        'Sens_x,Sens_y,Sens_z,'...
        'a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,'...
        'Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,J'];
    fprintf(fid,'%189s',header);
    fclose(fid);
    dlmwrite(csv_complete,' ','-append');
    
    % define reference quaternion
    if (nargin == 2 && nodeID == refnode)
%         q0_ref = fqa(data(1,c0+14),data(1,c0+15),data(1,c0+16),...
%             data(1,c0+17),data(1,c0+18),data(1,c0+19));
        q0_ref = data(1,c0:c0+3);
        j_ref = j;
    end
    
    x_nodes(j,:,:) = xKF(dt,data,c0,csv_complete);
end

if nargin == 2
    % repeat for relative node orientations
    rel_data = data;
    for j = 1:n_nodes
        c0 = 24*(j-1) + 2;
%         q0 = fqa(data(1,c0+14),data(1,c0+15),data(1,c0+16),...
%             data(1,c0+17),data(1,c0+18),data(1,c0+19));
        q0 = data(1,c0:c0+3);
        for i=1:n
%             q_ref = fqa(data(i,c_ref+14),data(i,c_ref+15),...
%                 data(i,c_ref+16),data(i,c_ref+17),data(i,c_ref+18),...
%                 data(i,c_ref+19));
%             q = fqa(data(i,c0+14),data(i,c0+15),...
%                 data(i,c0+16),data(i,c0+17),data(i,c0+18),...
%                 data(i,c0+19));
            q_ref = x_nodes(j_ref,i,4:7);
            q = x_nodes(j,i,4:7);
            q_rel = q_quot(q_quot(q,q_ref),q_quot(q0,q0_ref));
            iqr = q_quot([1 0 0 0],q_quot(q,q_ref));
%             rel_data(i,c0:c0+3) = q_quot(data(i,c0:c0+3),q_rel);  % Gq
            rel_data(i,c0:c0+3) = q_rel;
            rel_data(i,c0+14:c0+16) = vq(iqr,data(i,c0+14:c0+16));  % acc
            rel_data(i,c0+17:c0+19) = vq(iqr,data(i,c0+17:c0+19));  % mag
            rel_data(i,c0+20:c0+22) = vq(iqr,data(i,c0+20:c0+22));  % gyro
        end
    end
    
    for j = 1:n_nodes
        % identify node
        c0 = 24*(j-1) + 2;
        nodeID = str2double(cols{c0}(5:6));
        
        % create post-process files
        if nodeID ~= refnode
            csv_rel = [filename(1:name-4) '-node' num2str(nodeID) ...
                '-post-process-rel.csv'];
            fid = fopen(csv_rel,'w');
            header = ['time,EqKm_x,EqKm_y,EqKm_z,QTx_x,QTx_y,QTx_z,'...
                'EKin_x,EKin_y,EKin_z,QKin_x,QKin_y,QKin_z,'...
                'Sens_x,Sens_y,Sens_z,'...
                'a_x,a_y,a_z,m_x,m_y,m_z,g_x,g_y,g_z,'...
                'Km_g_x,Km_g_y,Km_g_z,qKm_w,qKm_x,qKm_y,qKm_z,J'];
            fprintf(fid,'%189s',header);
            fclose(fid);
            dlmwrite(csv_rel,' ','-append');
            
            xKF(dt,rel_data,c0,csv_rel);
        end
    end
end