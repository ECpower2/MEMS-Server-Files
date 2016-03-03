function out = model
%
% busbar2.m
%
% Model exported on Dec 10 2013, 09:06 by COMSOL 4.3.2.189.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Users/aubrynm/Documents/MATLAB');

model.name('busbar2.mph');

model.param.set('L', '9[cm]', 'Length of the busbar');
model.param.set('rad_1', '6[mm]', 'Radius of the fillet');
model.param.set('tbb', '5[mm]', 'Thickness');
model.param.set('wbb', '5[cm]', 'Width');
model.param.set('mh', '6[mm]', 'Maximum element size');
model.param.set('htc', '5[W/m^2/K]', 'Heat transfer coefficient');
model.param.set('Vtot', '20[mV]', 'Applied electric potential');

model.modelNode.create('mod1');

model.geom.create('geom1', 3);
model.geom('geom1').feature.create('wp1', 'WorkPlane');
model.geom('geom1').feature.create('ext1', 'Extrude');
model.geom('geom1').feature.create('wp2', 'WorkPlane');
model.geom('geom1').feature.create('ext2', 'Extrude');
model.geom('geom1').feature.create('wp3', 'WorkPlane');
model.geom('geom1').feature.create('ext3', 'Extrude');
model.geom('geom1').feature('wp1').geom.feature.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature.create('r2', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature.create('dif1', 'Difference');
model.geom('geom1').feature('wp1').geom.feature.create('fil1', 'Fillet');
model.geom('geom1').feature('wp1').geom.feature.create('fil2', 'Fillet');
model.geom('geom1').feature('wp2').geom.feature.create('c1', 'Circle');
model.geom('geom1').feature('wp3').geom.feature.create('c2', 'Circle');
model.geom('geom1').feature('wp3').geom.feature.create('copy1', 'Copy');
model.geom('geom1').feature('wp1').set('quickplane', 'xz');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'L+2*tbb' '0.1'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('pos', {'0' 'tbb'});
model.geom('geom1').feature('wp1').geom.feature('r2').set('size', {'L+tbb' '0.1-tbb'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input2').set({'r2'});
model.geom('geom1').feature('wp1').geom.feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('wp1').geom.feature('fil1').set('radius', 'tbb');
model.geom('geom1').feature('wp1').geom.feature('fil1').selection('point').set('dif1(1)', [3]);
model.geom('geom1').feature('wp1').geom.feature('fil2').set('radius', '2*tbb');
model.geom('geom1').feature('wp1').geom.feature('fil2').selection('point').set('fil1(1)', [6]);
model.geom('geom1').feature('ext1').set('distance', 'wbb');
model.geom('geom1').feature('ext1').selection('input').set({'wp1'});
model.geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp2').selection('face').set('ext1(1)', [8]);
model.geom('geom1').feature('wp2').geom.feature('c1').set('r', 'rad_1');
model.geom('geom1').feature('ext2').set('distance', '-2*tbb');
model.geom('geom1').feature('ext2').selection('input').set({'wp2'});
model.geom('geom1').feature('wp3').set('planetype', 'faceparallel');
model.geom('geom1').feature('wp3').selection('face').set('ext1(1)', [4]);
model.geom('geom1').feature('wp3').geom.feature('c2').set('r', 'rad_1');
model.geom('geom1').feature('wp3').geom.feature('c2').set('pos', {'-L/2+1.5e-2' '-wbb/4'});
model.geom('geom1').feature('wp3').geom.feature('copy1').set('disply', 'wbb/2');
model.geom('geom1').feature('wp3').geom.feature('copy1').selection('input').set({'c2'});
model.geom('geom1').feature('ext3').set('distance', '-2*tbb');
model.geom('geom1').feature('ext3').selection('input').set({'wp3.c2' 'wp3.copy1'});
model.geom('geom1').run;

model.selection.create('sel1', 'Explicit');
model.selection('sel1').set([2 3 4 5 6 7]);
model.selection('sel1').name('Ti bolts');
model.selection('sel1').name('Explicit 1');

model.material.create('mat1');
model.material.create('mat2');
model.material('mat2').selection.named('sel1');

model.physics.create('jh', 'JouleHeating', 'geom1');
model.physics('jh').feature.create('hf1', 'HeatFluxBoundary', 2);
model.physics('jh').feature('hf1').selection.set([1 2 3 4 5 6 7 9 10 11 12 13 14 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42]);
model.physics('jh').feature.create('pot1', 'ElectricPotential', 2);
model.physics('jh').feature('pot1').selection.set([43]);
model.physics('jh').feature.create('gnd1', 'Ground', 2);
model.physics('jh').feature('gnd1').selection.set([8 15]);

model.mesh.create('mesh1', 'geom1');
model.mesh('mesh1').feature.create('ftet1', 'FreeTet');

model.material('mat1').name('Copper');
model.material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat1').propertyGroup('def').set('density', '8700[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.material('mat2').name('Titanium');
model.material('mat2').propertyGroup('def').set('electricconductivity', {'7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]' '0' '0' '0' '7.407e5[S/m]'});
model.material('mat2').propertyGroup('def').set('heatcapacity', '710[J/(kg*K)]');
model.material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.material('mat2').propertyGroup('def').set('density', '4940[kg/m^3]');
model.material('mat2').propertyGroup('def').set('thermalconductivity', {'7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]' '0' '0' '0' '7.5[W/(m*K)]'});

model.physics('jh').feature('hf1').set('HeatFluxType', 'InwardHeatFlux');
model.physics('jh').feature('hf1').set('h', 'htc');
model.physics('jh').feature('pot1').set('V0', 'Vtot');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hcurve', '0.2');
model.mesh('mesh1').feature('size').set('hmax', 'mh');
model.mesh('mesh1').feature('size').set('hmin', 'mh-mh/3');
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').feature.create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').feature.create('st1', 'StudyStep');
model.sol('sol1').feature.create('v1', 'Variables');
model.sol('sol1').feature.create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature.create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').feature.create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.study('std1').feature('stat').set('initstudyhide', 'on');
model.study('std1').feature('stat').set('initsolhide', 'on');
model.study('std1').feature('stat').set('notstudyhide', 'on');
model.study('std1').feature('stat').set('notsolhide', 'on');

model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup3D');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg2').feature.create('surf1', 'Surface');
model.result.export.create('data1', 'Data');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').name('Compile Equations: Stationary');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').feature('v1').feature('mod1_V').name('mod1.V');
model.sol('sol1').feature('v1').feature('mod1_T').name('mod1.T');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').feature('s1').set('stol', '0.001');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol1').runAll;

model.result('pg1').feature('surf1').set('rangecolormin', '322.6');
model.result('pg1').feature('surf1').set('rangecolormax', '323.3');
model.result('pg1').feature('surf1').set('rangecoloractive', 'on');
model.result('pg2').set('title', 'Current density norm (A/m^2)');
model.result('pg2').set('titletype', 'manual');
model.result('pg2').feature('surf1').set('expr', 'jh.normJ');
model.result('pg2').feature('surf1').set('unit', 'A/m^2');
model.result('pg2').feature('surf1').set('rangecolormax', '1e6');
model.result('pg2').feature('surf1').set('descr', 'Current density norm');
%model.result('pg2').feature('surf1').set('expr','jh.Qtot');
%model.result('pg2').feature('surf1').set('rangecolormax','1e4');
model.result('pg2').feature('surf1').set('rangecoloractive', 'on');
model.result.export('data1').set('expr', {'T'});
model.result.export('data1').set('unit', {'K'});
model.result.export('data1').set('filename', 'Temperature.txt');
model.result.export('data1').set('descr', {'Temperature'});

out = model;
