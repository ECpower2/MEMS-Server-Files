function [xV,zV] = test_mems_filter_bias(ax,ay,az,Mx,My,Mz,gx,gy,gz)
% implements unscented Kalman filter for MEMS

n = 10;      %number of states
q = 0.1;    %std of process 
r = 0.1;    %std of measurement
Q = q^2*eye(n); % covariance of process
R = r^2;        % covariance of measurement  
tau = 1;
f = @(x)[-(x(1)-x(4))/tau;-(x(2)-x(5))/tau;-(x(3)-x(6))/tau;...
    -x(4)/tau; -x(5)/tau; -x(6)/tau;...
    -.5*(x(8)*x(1)+x(9)*x(2)+x(10)*x(3))/norm([x(1) x(2) x(3)]);...
    .5*(x(7)*x(1)+x(9)*x(3)-x(10)*x(2))/norm([x(1) x(2) x(3)]);...
    .5*(x(7)*x(2)-x(8)*x(3)+x(10)*x(1))/norm([x(1) x(2) x(3)]);...
    .5*(x(7)*x(3)+x(8)*x(2)-x(9)*x(1))/norm([x(1) x(2) x(3)])]; 
                                        % nonlinear state equations
h = @(x) [x(1);x(2);x(3);x(7);x(8);x(9);x(10)];   % measurement equation
q_fqa = fqa(ax,ay,az,Mx,My,Mz);
x = [gx(1);gy(1);gz(1);0.1;0.1;0.1;q_fqa(1,:)'];      % initial state
P = eye(n);                               % initial state covariance
N=length(ax);                             % total dynamic steps
xV = zeros(n,N);          %estimate        % allocate memory
zV = [gx';gy';gz';q_fqa'];
for k=1:N
  z = zV(:,k);                            % measurements
  [x,P] = ukf(f,x,P,h,z,Q,R);            % ekf 
  xV(:,k) = x;                            % save estimate
end
for k=1:7                                 % plot results
  subplot(7,1,k)
  plot(1:N, zV(k,:), '-', 1:N, xV(k,:), '--')
end