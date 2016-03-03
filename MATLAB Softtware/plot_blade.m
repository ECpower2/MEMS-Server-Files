function beams = plot_blade(filename,rs,rf,n_to_avg,spacing)
% plots blade deflections calculated by beam_shape_live.m

if nargin < 4
    spacing = 100;
end
if nargin < 3
    n_to_avg = 99;
end

n = floor((rf-rs)/spacing);
re = rs + n_to_avg;
p1 = zeros(1,n); p2 = p1; p3 = p1; id = cell(1,n); i = 1;
while re < rf
    [p1(i),p2(i),p3(i),~] = beam_shape_live(filename,rs,re);
    id{i} = num2str(re/100);
    i = i+1;
    rs = re + spacing - n_to_avg;
    re = re + spacing;
end

x = linspace(0,.65);
beams = zeros(100,n);
for i = 1:n
beams(:,i) = p1(i)*x.^3/3+p2(i)*x.^2/2+p3(i)*x;
end
figure;
plot(x,beams)
legend(id)
% ylim([-.005 .06])