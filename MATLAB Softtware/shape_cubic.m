function [w,a] = shape_cubic(x,s)
% shape estimation using measured slope s at locations x (3rd order)
% based on Kirby et al (1997). Strain-based shape estimation algorithms for 
% a cantilever beam (Proc. SPIE Vol. 3041, pp. 788-798).

n = length(x);  % number of sensors (+ root [zero slope])
m = (n-1)/3;
if mod(m,1)~=0
    m = floor(m);
    warning(['Warning: number of sensors (+ root) should be equal to '...
        '3n + 1 for integer n. Removing last data point(s).']);
    x = x(1:3*m);
    s = s(1:3*m);
end

xij = zeros(m,4);
sij = zeros(4*m,1);
A = zeros(4*m,5*m);
B = zeros(4*m,5*m);
C = zeros(m,5*m);

ni = 0;
for i = 1:m
    xij(i,1) = x(3*i-2);
    xij(i,2) = x(3*i-1);
    xij(i,3) = x(3*i);
    xij(i,4) = x(3*i+1);
    for j = 1:4
        A(4*(i-1)+j,5*i-4:5*i-1) = [xij(i,j)^3 xij(i,j)^2 xij(i,j) 1];
        B(4*(i-1)+j,5*i-4:5*i) = [xij(i,j)^4/4 xij(i,j)^3/3 xij(i,j)^2/2 ...
            xij(i,j) 1];
        sij(4*(i-1)+j) = s(4*(i-1)+j-ni);
    end
    ni = ni+1;
end
for i = 1:m-1
    C(i,5*i-4:5*(i+1)) = [xij(i,4)^4/4 xij(i,4)^3/3 xij(i,4)^2/2 ...
        xij(i,4) 1 -xij(i+1,1)^4/4 -xij(i+1,1)^3/3 -xij(i+1,1)^2/2 ...
        -xij(i+1,1) -1];
end
C(m,1:5) = [xij(1,1)^4/4 xij(1,1)^3/3 xij(1,1)^2/2 xij(1,1) 1];

sol = [2*(A.'*A) C.'; C zeros(m)]\[2*A.'; zeros(m,4*m)]*sij;
a = sol(1:5*m);
w = B*a;

figure; 
plot (reshape(xij',4*m,1),w)
xlabel('Position')
ylabel('Deflection')