function beamSept_comsol(model,filename)
% calculates deformation parameters and passes them to COMSOL for
% strain calculation

% open COMSOL with MATLAB first with model cantilever_beam_alum.m

[p1,p2,p3,~] = beam_data_Sept(filename);

model.param.set('a1',p1);
model.param.set('b1',p2);
model.param.set('c1',p3);
model.sol('sol1').run;

figure; mphplot(model,'pg1','rangenum',1);
figure; mphplot(model,'pg3','rangenum',1);
figure; mphplot(model,'pg4','rangenum',1);