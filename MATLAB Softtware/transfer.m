function [Mx,My0psi,My0th,My0phi,Mz0phi,Mz0th,Mz0psi] = transfer()

phi = linspace(-pi,pi);
theta = linspace(-pi,pi);
psi = linspace(-pi,pi);
Mx = zeros(100,100); My0phi = Mx; My0th = Mx; My0psi = Mx;
Mz0phi = Mx; Mz0th = Mx; Mz0psi = Mx;
for i=1:100
    for j=1:100
    Mx(i,j) = 19.2*cos(theta(j)).*cos(psi(i))-.9*sin(theta(j));
    My0psi(i,j) = 19.2*(sin(phi(i)).*sin(theta(j)))+.9*sin(phi(i)).*cos(theta(j));
    My0th(i,j) = 19.2*(cos(phi(i)).*sin(psi(j)))+.9*sin(phi(i));
    My0phi(i,:) = 19.2*(sin(psi(i)));
    Mz0psi(i,j) = 19.2*(-cos(phi(i)).*sin(theta(j)))-.9*cos(phi(i)).*cos(theta(j));
    Mz0th(i,j) = 19.2*(sin(phi(i)).*sin(psi(j)))-.9*cos(phi(i));
    Mz0phi(i,j) = 19.2*(-sin(theta(j)).*cos(psi(i)))-.9*cos(theta(j));
    end
end

figure
surf(theta,psi,Mx')
xlabel('\theta'); ylabel('\psi'); zlabel('Mx-myax')
figure
surf(theta,psi,My0phi')
xlabel('\theta'); ylabel('\psi'); zlabel('My-myay (\phi = 0)')
figure
surf(theta,psi,Mz0phi')
xlabel('\theta'); ylabel('\psi'); zlabel('Mz-myaz (\phi = 0)')
figure
surf(theta,phi,My0psi')
xlabel('\theta'); ylabel('\phi'); zlabel('My-myay (\psi = 0)')
figure
surf(theta,phi,Mz0psi')
xlabel('\theta'); ylabel('\phi'); zlabel('Mz-myaz (\psi = 0)')
figure
surf(phi,psi,My0th)
xlabel('\phi'); ylabel('\psi'); zlabel('My-myay (\theta = 0)')
figure
surf(phi,psi,Mz0th)
xlabel('\phi'); ylabel('\psi'); zlabel('Mz-myaz (\theta = 0)')