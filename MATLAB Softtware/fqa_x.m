function [q,q_e,q_r,q_a] = fqa_x(ax,ay,az,Mx,My,Mz)
% calculates orientation quaternion based on method of Yun, Bachmann and
% McGhee (2008)
% extended output (includes elevation, roll and azimuth quaternions) for
% debugging

% uses NED coordinate system: +x = north, +y = east, +z = down

q = zeros(length(ax),4); q_e = q; q_r = q; q_a = q; q_an = q;

% calculate normalized local magnetic field vector
mag_field = [19.1171 .1219 45.0869];  % Kluyverweg, Delft, Sept. 2014
n = norm(mag_field);
n_x = mag_field(1)/n;
n_y = mag_field(2)/n;
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
    q_e(i,:) = [cos_h_el 0 sin_h_el 0];
        
    % calculate roll quaternion
    if cos_el ~= 0
        sin_ro = -ayn/cos_el;
        cos_ro = -azn/cos_el;
    else
        sin_ro = 0;
        cos_ro = 1;
    end
    s = sign(sin_ro);
    if s == 0; s = 1; end
    sin_h_ro = s*sqrt((1-cos_ro)/2);
    cos_h_ro = sqrt((1+cos_ro)/2);
    q_r(i,:) = [cos_h_ro sin_h_ro 0 0];
        
    % normalize magnetic field measurements
    body_m = [Mx(i) My(i) Mz(i)]/norm([Mx(i) My(i) Mz(i)]);
    
    % calculate azimuth quaternion
%     earth_m = vq(q_prod(q_e(i,:),q_r(i,:)),body_m);
    earth_m = vq(q_quot([1 0 0 0],q_prod(q_r(i,:),q_e(i,:))),body_m);
    m = sqrt(earth_m(1)^2 + earth_m(2)^2);
    M_x = earth_m(1)/m;
    M_y = earth_m(2)/m;
    cos_az = dot([M_x M_y],N);
    sin_az = dot([-M_y M_x],N);
    sin_h_az = sign(sin_az)*sqrt((1-cos_az)/2);
    cos_h_az = sqrt((1+cos_az)/2);
    q_a(i,:) = [cos_h_az 0 0 sin_h_az];
    
    % normalize azimuth quaternion based on initial value
    q_an(i,:) = q_quot(q_a(i,:),q_a(1,:));
        
    % calculate orientation quaternion
    q(i,:) = q_prod(q_an(i,:),q_prod(q_e(i,:),q_r(i,:)));
        
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
%             sin_ro = -ayn/cos_el;
%             cos_ro = -azn/cos_el;
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