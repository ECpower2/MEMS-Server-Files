function blade_comsol_live(model,filename)
% calculates deformation parameters and passes them to COMSOL for
% strain calculation

% open COMSOL with MATLAB first with model blade_bending_test.m

rs = 201;
re = 300;

while re < 1000
    [p1,p2,p3,~] = beam_shape_live(filename,rs,re);

    model.param.set('a1',p1);
    model.param.set('b1',p2);
    model.param.set('c1',p3);
    model.sol('sol1').run;

    figure; mphplot(model,'pg1','rangenum',1);
    figure; mphplot(model,'pg3','rangenum',1);
    figure; mphplot(model,'pg4','rangenum',1);
    
    rs = re+1;
    re = re+100;
end