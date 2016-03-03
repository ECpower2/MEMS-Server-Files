function w = shape_lin(x,s)
% shape estimation using measured slope s at locations x (linear estimate)
% based on Kirby et al (1997). Strain-based shape estimation algorithms for 
% a cantilever beam (Proc. SPIE Vol. 3041, pp. 788-798).

n = length(x);  % number of sensors (+ root [zero slope])
m = n-1;

xij = zeros(m,2);
sij = zeros(2*m,1);
A = zeros(2*m,3*m);
B = zeros(2*m,3*m);
C = zeros(m,3*m);

ni = 0;
for i = 1:m
    xij(i,1) = x(i);
    xij(i,2) = x(i+1);
    for j = 1:2
        A(2*(i-1)+j,3*i-2:3*i-1) = [xij(i,j) 1];
        B(2*(i-1)+j,3*i-2:3*i) = [xij(i,j)^2/2 xij(i,j) 1];
        sij(2*(i-1)+j) = s(2*(i-1)+j-ni);
    end
    ni = ni+1;
end
for i = 1:m-1
    C(i,3*i-2:3*(i+1)) = [xij(i,2)^2/2 xij(i,2) 1 -xij(i+1,1)^2/2 ...
        -xij(i+1,1) -1];
end
C(m,1:3) = [xij(1,1)^2/2 xij(1,1) 1];

sol = [2*(A.'*A) C.'; C zeros(m)]\[2*A.'; zeros(m,2*m)]*sij;
a = sol(1:3*m);
w = B*a;

figure; 
plot (reshape(xij',2*m,1),w)
xlabel('Position')
ylabel('Deflection')
