function [xV,zV] = test_mems_filter_ukf(ax,ay,az,Mx,My,Mz,gx,gy,gz,figs)
% implements unscented Kalman filter for MEMS

n = 7;      %number of state
q = 0.1;    %std of process 
r = 0.1;    %std of measurement
Q = q^2*eye(n); % covariance of process
R = r^2;        % covariance of measurement  
tau = 1;    % time constant
% f = @(x)[-x(1)/tau;-x(2)/tau;-x(3)/tau;...
%     -.5*(x(5)*x(1)+x(6)*x(2)+x(7)*x(3))/norm([x(1) x(2) x(3)]);...
%     .5*(x(4)*x(1)+x(6)*x(3)-x(7)*x(2))/norm([x(1) x(2) x(3)]);...
%     .5*(x(4)*x(2)-x(5)*x(3)+x(7)*x(1))/norm([x(1) x(2) x(3)]);...
%     .5*(x(4)*x(3)+x(5)*x(2)-x(6)*x(1))/norm([x(1) x(2) x(3)])]; 
                                        % nonlinear state equations
dt = 0.01;
f = @(x)([exp(-dt/tau) 0 0 0 0 0 0; 0 exp(-dt/tau) 0 0 0 0 0;...
    0 0 exp(-dt/tau) 0 0 0 0; ...
    -x(5)*dt/2 -x(6)*dt/2 -x(7)*dt/2 1 -x(1)*dt/2 -x(2)*dt/2 -x(3)*dt/2;...
    x(4)*dt/2 -x(7)*dt/2 x(6)*dt/2 x(1)*dt/2 1 x(3)*dt/2 -x(2)*dt/2;...
    x(7)*dt/2 x(4)*dt/2 -x(5)*dt/2 x(2)*dt/2 -x(3)*dt/2 1 x(1)*dt/2;...
    x(6)*dt/2 x(5)*dt/2 x(4)*dt/2 x(3)*dt/2 x(2)*dt/2 -x(1)*dt/2 1]*x);
h = @(x)x;                                  % measurement equation
q_fqa = fqa(ax,ay,az,Mx,My,Mz);
x = [gx(1);gy(1);gz(1);q_fqa(1,:)'];      % initial state
P = eye(n);                               % initial state covariance
N=length(ax);                             % total dynamic steps
xV = zeros(n,N);          %estimate        % allocate memory
zV = [gx';gy';gz';q_fqa'];
for k=1:N
  z = zV(:,k);                            % measurements
  [x,P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
end
labels = {'g_x';'g_y';'g_z';'q_0';'q_1';'q_2';'q_3'};
if figs==1
    for k=1:n                                 % plot results
      subplot(n,1,k)
      plot(1:N, zV(k,:), '-', 1:N, xV(k,:), '--')
      ylabel(labels(k))
      if k==1
          legend('measurement','filter')
      end
    end
end