function q = fqa(ax,ay,az,Mx,My,Mz)
% calculates orientation quaternion based on method of Yun, Bachmann and
% McGhee (2008)

% uses NED coordinate system: +x = north, +y = east, +z = down
% therefore, motion node coordinates (+x = north, +y = up, +z = east)
% must be reassigned

q = zeros(length(ax),4);

% calculate normalized local magnetic field vector
n = norm([19.1171 45.0869 .1219]);
n_x = 19.1171/n;
n_y = .1219/n;
N = [n_x n_y]/sqrt(n_x^2 + n_y^2);

for i = 1:length(ax)
    % normalize accelerometer measurements
    axn = ax(i)/sqrt(ax(i)^2 + ay(i)^2 + az(i)^2);
    ayn = ay(i)/sqrt(ax(i)^2 + ay(i)^2 + az(i)^2);
    azn = az(i)/sqrt(ax(i)^2 + ay(i)^2 + az(i)^2);
    
    % calculate elevation quaternion
    cos_el = sqrt(1-axn^2);
    sin_h_el = sign(axn)*sqrt((1-cos_el)/2);
    cos_h_el = sqrt((1+cos_el)/2);
    q_e = [cos_h_el 0 sin_h_el 0];
        
    % calculate roll quaternion
    if cos_el ~= 0
        sin_ro = -azn/cos_el;
        cos_ro = ayn/cos_el;
    else
        sin_ro = 0;
        cos_ro = 1;
    end
    s = sign(sin_ro);
    if s == 0; s = 1; end
    sin_h_ro = s*sqrt((1-cos_ro)/2);
    cos_h_ro = sqrt((1+cos_ro)/2);
    q_r = [cos_h_ro sin_h_ro 0 0];
        
    % normalize magnetic field measurements
    body_m = [Mx(i) Mz(i) -My(i)]/norm([Mx(i) My(i) Mz(i)]);
    
    % calculate azimuth quaternion
    earth_m = vq(q_prod(q_e,q_r),body_m);
    m = sqrt(earth_m(1)^2 + earth_m(2)^2);
    M_x = earth_m(1)/m;
    M_y = earth_m(2)/m;
    cos_az = dot([M_x M_y],N);
    sin_az = dot([-M_y M_x],N);
    sin_h_az = sign(sin_az)*sqrt((1-cos_az)/2);
    cos_h_az = sqrt((1+cos_az)/2);
    q_a = [cos_h_az 0 0 sin_h_az];
        
    % calculate orientation quaternion
    q(i,:) = q_prod(q_a,q_prod(q_e,q_r));
        
    % use alternative method to avoid singularity at el = +-90 degrees
%     if cos_el < 0.1
%         warning('elevation singularity detected');
%         alpha = 20*pi/180;
%         q_alpha = [cos(alpha/2) 0 sin(alpha/2) 0];
%         xyz = vq(q_alpha,[axn ayn azn]);
%         axn = xyz(1); ayn = xyz(2); azn = xyz(3);
%         body_m = vq(q_alpha,body_m);
%         
%         % calculate elevation quaternion
%         cos_el = sqrt(1-axn^2);
%         sin_h_el = sign(axn)*sqrt((1-cos_el)/2);
%         cos_h_el = sqrt((1+cos_el)/2);
%         q_e = [cos_h_el 0 sin_h_el 0];
%         
%         % calculate roll quaternion
%         if cos_el ~= 0
%             sin_ro = -azn/cos_el;
%             cos_ro = ayn/cos_el;
%         else
%             sin_ro = 0;
%             cos_ro = 1;
%         end
%         s = sign(sin_ro);
%         if s == 0; s = 1; end
%         sin_h_ro = s*sqrt((1-cos_ro)/2);
%         cos_h_ro = sqrt((1+cos_ro)/2);
%         q_r = [cos_h_ro sin_h_ro 0 0];
%         
%         % calculate azimuth quaternion
%         earth_m = vq(q_prod(q_e,q_r),body_m);
%         m = sqrt(earth_m(1)^2 + earth_m(2)^2);
%         M_x = earth_m(1)/m;
%         M_y = earth_m(2)/m;
%         cos_az = dot([M_x M_y],N);
%         sin_az = dot([-M_y M_x],N);
%         sin_h_az = sign(sin_az)*sqrt((1-cos_az)/2);
%         cos_h_az = sqrt((1+cos_az)/2);
%         q_a = [cos_h_az 0 0 sin_h_az];
%        
%         % calculate orientation quaternion
%         q_alt = q_prod(q_a,q_prod(q_e,q_r));
%         q(i,:) = q_prod(q_alt,q_alpha);        
%     end
end

% reorder quaternion components to MN coordinates
r = [q(:,1) q(:,2) -q(:,4) q(:,3)];
q = r;