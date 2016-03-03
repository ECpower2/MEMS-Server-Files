function beam_comsol_live_param(model,filename)
% calculates deformation parameters and passes them to COMSOL for
% strain calculation

% open COMSOL with MATLAB first with model cantilever_beam_alum.m
% model.study('std1').feature.create('param', 'Parametric');
model.study('std1').feature('param').set('sweeptype','sparse');
model.study('std1').feature('param').set('plot', 'on');
model.study('std1').feature('param').set('plotgroup', 'pg3');

% model.sol('sol1').feature('s1').feature.create('p1', 'Parametric');

n = 7;
rs = 245;
re = 250;
p1 = zeros(1,n); p2 = p1; p3 = p1; i = 1;
while re < 500
    [p1(i),p2(i),p3(i),~] = beam_shape_live(filename,rs,re);
    i = i+1;
    rs = re+45;
    re = re+50;
end

plist = [p1; p2; p3];
model.study('std1').feature('param').set('plistarr', plist);
model.study('std1').feature('param').set('pname', {'a1' 'b1' 'c1'});

plist_str = {strcat(num2str(p1(1)),'[m^-2]'); ...
    strcat(num2str(p2(1)),'[1/m]'); num2str(p3(1))};
plist_str2 = cell(n,1);
% plist_str2{1} = strcat('"a1","',num2str(p1(1)),'","b1","',num2str(p2(1)),...
%     '","c1","',num2str(p3(1)),'"');
plist_str2{1} = strcat('a1,',num2str(p1(1)),',b1,',num2str(p2(1)),...
    ',c1,',num2str(p3(1)));
for i = 2:n
    plist_str{1} = strcat(plist_str{1},',',num2str(p1(i)),'[m^-2]');
    plist_str{2} = strcat(plist_str{2},',',num2str(p2(i)),'[1/m]');
    plist_str{3} = strcat(plist_str{3},',',num2str(p3(i)));
%     plist_str2{i} = strcat('"a1","',num2str(p1(i)),'","b1","',num2str(p2(i)),...
%     '","c1","',num2str(p3(i)),'"');
    plist_str2{i} = strcat('a1,',num2str(p1(i)),',b1,',num2str(p2(i)),...
    ',c1,',num2str(p3(i)));
end
plist_str = reshape(plist_str,[1,3]);
plist_str2 = reshape(plist_str2,[1,n]);
model.batch('p1').set('plotgroup', 'pg3');
model.batch('p1').set('plistarr', plist_str);
model.batch('p1').set('err', true);
model.batch('p1').set('pname', {'a1' 'b1' 'c1'});
model.batch('p1').set('control', 'param');
model.batch('p1').set('plot', 'on');
model.batch('p1').feature('so1').set('param', plist_str2);
model.batch('p1').feature('so1').set('psol', 'sol2');
model.batch('p1').feature('so1').set('seq', 'sol1');
model.batch('p1').attach('std1');
model.batch('p1').run;

figure; mphplot(model,'pg1','rangenum',1);
figure; mphplot(model,'pg3','rangenum',1);
figure; mphplot(model,'pg4','rangenum',1);

end