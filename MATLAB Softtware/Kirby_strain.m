function w = Kirby_strain(x,eps)
% shape estimation using measured strain eps at locations x
% see Kirby et al (1997). Strain-based shape estimation algorithms for 
% a cantilever beam (Proc. SPIE Vol. 3041, pp. 788?798).

n = length(x);  % number of sensors (+ tip [zero strain])
m = (n-1)/2;
z = 1;        % displacement from neutral axis
if mod(m,1)~=0
    m = floor(m);
    warning(['Warning: number of sensors (+ tip) should be odd. '...
        'Removing last data point.']);
    x = x(1:n-1);
    eps = eps(1:n-1);
end

xij = zeros(m,3);
eij = zeros(3*m,1);
A = zeros(3*m,5*m);
B = zeros(3*m,5*m);
C = zeros(2*m,5*m);

ni = 0;
for i = 1:m
    xij(i,1) = x(2*i-1);
    xij(i,2) = x(2*i);
    xij(i,3) = x(2*i+1);
    for j = 1:3
        A(3*(i-1)+j,5*i-4:5*i-2) = z*[xij(i,j)^2 xij(i,j) 1];
        B(3*(i-1)+j,5*i-4:5*i) = [xij(i,j)^4/12 xij(i,j)^3/6 xij(i,j)^2/2 ...
            xij(i,j) 1];
        eij(3*(i-1)+j) = eps(3*(i-1)+j-ni);
    end
    ni = ni+1;
end
for i = 1:m-1
    C(i,5*i-4:5*(i+1)) = [xij(i,3)^4/12 xij(i,3)^3/6 xij(i,3)^2/2 ...
        xij(i,3) 1 -xij(i+1,1)^4/12 -xij(i+1,1)^3/6 -xij(i+1,1)^2/2 ...
        -xij(i+1,1) -1];
    C(m-1+i,5*i-4:5*(i+1)) = [xij(i,3)^3/3 xij(i,3)^2/2 xij(i,3) 1 0 ...
        -xij(i+1,1)^3/3 -xij(i+1,1)^2/2 -xij(i+1,1) -1 0];
end
C(2*m-1,1:5) = [xij(1,1)^4/12 xij(1,1)^3/6 xij(1,1)^2/2 xij(1,1) 1];
C(2*m,1:4) = [xij(1,1)^3/3 xij(1,1)^2/2 xij(1,1) 1];

sol = [2*(A.'*A) C.'; C zeros(2*m)]\[2*A.'; zeros(2*m,3*m)]*eij;
a = sol(1:5*m);
w = B*a;
