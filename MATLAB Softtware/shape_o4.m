function w = shape_o4(x,s)
% shape estimation using measured slope s at locations x (4th order)
% based on Kirby et al (1997). Strain-based shape estimation algorithms for 
% a cantilever beam (Proc. SPIE Vol. 3041, pp. 788-798).

n = length(x);  % number of sensors (+ root [zero slope])
m = (n-1)/4;
if mod(m,1)~=0
    m = floor(m);
    warning(['Warning: number of sensors (+ root) should be equal to '...
        '4n + 1 for integer n. Removing last data point(s).']);
    x = x(1:4*m);
    s = s(1:4*m);
end

xij = zeros(m,5);
sij = zeros(5*m,1);
A = zeros(5*m,6*m);
B = zeros(5*m,6*m);
C = zeros(m,6*m);

ni = 0;
for i = 1:m
    xij(i,1) = x(4*i-3);
    xij(i,2) = x(4*i-2);
    xij(i,3) = x(4*i-1);
    xij(i,4) = x(4*i);
    xij(i,5) = x(4*i+1);
    for j = 1:5
        A(5*(i-1)+j,6*i-5:6*i-1) = [xij(i,j)^4 xij(i,j)^3 xij(i,j)^2 ...
            xij(i,j) 1];
        B(5*(i-1)+j,6*i-5:6*i) = [xij(i,j)^5/5 xij(i,j)^4/4 xij(i,j)^3/3 ...
            xij(i,j)^2/2 xij(i,j) 1];
        sij(5*(i-1)+j) = s(5*(i-1)+j-ni);
    end
    ni = ni+1;
end
for i = 1:m-1
    C(i,6*i-5:6*(i+1)) = [xij(i,5)^5/5 xij(i,5)^4/4 xij(i,5)^3/3 ...
        xij(i,5)^2/2 xij(i,5) 1 -xij(i+1,1)^5/5 -xij(i+1,1)^4/4 ...
        -xij(i+1,1)^3/3 -xij(i+1,1)^2/2 -xij(i+1,1) -1];
end
C(m,1:6) = [xij(1,1)^5/5 xij(1,1)^4/4 xij(1,1)^3/3 xij(1,1)^2/2 ...
    xij(1,1) 1];

sol = [2*(A.'*A) C.'; C zeros(m)]\[2*A.'; zeros(m,5*m)]*sij;
a = sol(1:6*m);
w = B*a;

figure; 
plot (reshape(xij',5*m,1),w)
xlabel('Position')
ylabel('Deflection')