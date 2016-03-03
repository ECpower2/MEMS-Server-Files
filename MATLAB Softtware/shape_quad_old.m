function w = shape_quad(x,s)
% shape estimation using measured slope s at locations x (2nd order)
% based on Kirby et al (1997). Strain-based shape estimation algorithms for 
% a cantilever beam (Proc. SPIE Vol. 3041, pp. 788-798).

n = length(x);  % number of sensors (+ root [zero slope])
m = (n-1)/2;
if mod(m,1)~=0
    m = floor(m);
    warning(['Warning: number of sensors (+ root) should be odd. '...
        'Removing last data point.']);
    x = x(1:n-1);
    s = s(1:n-1);
end

xij = zeros(m,3);
sij = zeros(3*m,1);
A = zeros(3*m,4*m);
B = zeros(3*m,4*m);
C = zeros(m,4*m);

ni = 0;
for i = 1:m
    xij(i,1) = x(2*i-1);
    xij(i,2) = x(2*i);
    xij(i,3) = x(2*i+1);
    for j = 1:3
        A(3*(i-1)+j,4*i-3:4*i-1) = [xij(i,j)^2 xij(i,j) 1];
        B(3*(i-1)+j,4*i-3:4*i) = [xij(i,j)^3/3 xij(i,j)^2/2 xij(i,j) 1];
        sij(3*(i-1)+j) = s(3*(i-1)+j-ni);
    end
    ni = ni+1;
end
for i = 1:m-1
    C(i,4*i-3:4*(i+1)) = [xij(i,3)^3/3 xij(i,3)^2/2 xij(i,3) 1 ...
        -xij(i+1,1)^3/3 -xij(i+1,1)^2/2 -xij(i+1,1) -1];
end
C(m,1:4) = [xij(1,1)^3/3 xij(1,1)^2/2 xij(1,1) 1];

sol = [2*(A.'*A) C.'; C zeros(m)]\[2*A.'; zeros(m,3*m)]*sij;
a = sol(1:4*m);
w = B*a;

figure; 
plot (reshape(xij',3*m,1),w)
xlabel('Position')
ylabel('Deflection')

wx = reshape(w,3,m);
w = reshape(wx(1:2,:),2*m,1); w(2*m+1) = wx(3,m);
