function out = model
%
% bending_beam.m
%
% Model exported on Dec 9 2013, 15:32 by COMSOL 4.3.2.189.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/Users/aubrynm/Documents/COMSOL');

model.modelNode.create('mod1');

model.geom.create('geom1', 3);

model.mesh.create('mesh1', 'geom1');

model.physics.create('solid', 'SolidMechanics', 'geom1');

model.study.create('std1');
model.study('std1').feature.create('stat', 'Stationary');
model.study('std1').feature('stat').activate('solid', true);

model.geom('geom1').feature.create('blk1', 'Block');
model.geom('geom1').feature('blk1').setIndex('size', '.08', 0);
model.geom('geom1').feature('blk1').setIndex('size', '0.8', 1);
model.geom('geom1').feature('blk1').setIndex('size', '0.008', 2);
model.geom('geom1').run('blk1');
model.geom('geom1').feature.duplicate('blk2', 'blk1');
model.geom('geom1').feature('blk2').setIndex('pos', '-0.008', 1);
model.geom('geom1').run('blk2');
model.geom('geom1').feature('blk2').setIndex('pos', '0', 1);
model.geom('geom1').feature('blk2').setIndex('pos', '-0.008', 2);
model.geom('geom1').run('blk2');
model.geom('geom1').run;

model.material.create('mat1');
model.material('mat1').name('Nylon');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('lighting', 'phong');
model.material('mat1').set('fresnel', 0.5);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('specular', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.39215686274509803 0.39215686274509803 0.9803921568627451]);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.39215686274509803 0.39215686274509803 0.7843137254901961]);
model.material('mat1').set('shininess', 500);
model.material('mat1').propertyGroup('def').set('heatcapacity', '1700[J/(kg*K)]');
model.material('mat1').propertyGroup('def').set('relpermittivity', '4');
model.material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', '280e-6[1/K]');
model.material('mat1').propertyGroup('def').set('density', '1150[kg/m^3]');
model.material('mat1').propertyGroup('def').set('thermalconductivity', '0.26[W/(m*K)]');
model.material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.material('mat1').propertyGroup('Enu').set('poissonsratio', '0.4');
model.material('mat1').propertyGroup('Enu').set('youngsmodulus', '2e9[Pa]');
model.material('mat1').set('family', 'custom');
model.material('mat1').set('lighting', 'phong');
model.material('mat1').set('fresnel', 0.5);
model.material('mat1').set('roughness', 0.1);
model.material('mat1').set('specular', 'custom');
model.material('mat1').set('customspecular', [0.7843137254901961 0.7843137254901961 0.7843137254901961]);
model.material('mat1').set('diffuse', 'custom');
model.material('mat1').set('customdiffuse', [0.39215686274509803 0.39215686274509803 0.9803921568627451]);
model.material('mat1').set('ambient', 'custom');
model.material('mat1').set('customambient', [0.39215686274509803 0.39215686274509803 0.7843137254901961]);
model.material('mat1').set('shininess', 500);

model.physics('solid').feature.create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([2 5]);
model.physics('solid').feature.create('disp1', 'Displacement1', 1);
model.physics('solid').feature('disp1').selection.set([12]);
model.physics('solid').feature('disp1').set('Direction', 1, '1');
model.physics('solid').feature('disp1').set('Direction', 2, '1');
model.physics('solid').feature('disp1').set('Direction', 3, '1');
model.physics('solid').feature('disp1').set('U0', 3, '0.02');

model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature.create('map1', 'Map');
model.mesh('mesh1').feature('map1').selection.set([8 9]);
model.mesh('mesh1').feature('ftet1').active(false);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature.remove('map1');
model.mesh('mesh1').automatic(true);

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').feature.create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').feature.create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').feature.create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature.create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature('fc1').set('termonres', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('reserrfact', 1000);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 3);
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', {'solid.mises'});
model.result('pg1').name('Stress (solid)');
model.result('pg1').feature('surf1').feature.create('def', 'Deform');
model.result('pg1').feature('surf1').feature('def').set('expr', {'u' 'v' 'w'});
model.result('pg1').feature('surf1').feature('def').set('descr', 'Displacement field (Material)');

model.sol('sol1').runAll;

model.result('pg1').run;

model.name('bending_beam.mph');

model.result('pg1').run;

out = model;
