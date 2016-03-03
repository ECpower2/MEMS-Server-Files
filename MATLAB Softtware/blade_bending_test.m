function out = model
%
% blade_bending_test.m
%
% Model exported on Jul 3 2015, 13:51 by COMSOL 4.4.0.248.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('D:\acooperman\My Documents\WindChallenge');

model.name('blade_bending_test.mph');

model.modelNode.create('mod1');
model.modelNode('mod1').name('Model 1');

model.geom.create('geom1', 3);
model.geom('geom1').feature.create('imp1', 'Import');
model.geom('geom1').feature.create('dsl1', 'DeleteSliverFaces');
model.geom('geom1').feature.create('pt1', 'Point');
model.geom('geom1').feature.create('cme1', 'CompositeEdges');
model.geom('geom1').feature.create('ige1', 'IgnoreEdges');
model.geom('geom1').feature.create('mrv1', 'MergeVertices');
model.geom('geom1').feature.create('cle1', 'CollapseEdges');
model.geom('geom1').feature.create('mre1', 'MergeEdges');
model.geom('geom1').feature('imp1').set('type', 'cad');
model.geom('geom1').feature('imp1').set('filename', '/Users/aubrynm/Documents/COMSOL/WindChallenge/0239-01-3001 Wing.STEP');
model.geom('geom1').feature('dsl1').set('entsize', '0.0014');
model.geom('geom1').feature('dsl1').selection('input').set({'imp1'});
model.geom('geom1').feature('dsl1').find;
model.geom('geom1').feature('dsl1').detail.setGroup([1 2 3 4 5 13]);
model.geom('geom1').feature('pt1').setIndex('p', '.01', 0, 0);
model.geom('geom1').feature('pt1').setIndex('p', '0', 1, 0);
model.geom('geom1').feature('pt1').setIndex('p', '-.8', 2, 0);
model.geom('geom1').feature('cme1').selection('input').set('fin(1)', [16 19 20]);
model.geom('geom1').feature('ige1').selection('input').set('cme1(1)', [1 2 3 7 13 14 15 18 52 53 54 70 72 74 77 80 81 83]);
model.geom('geom1').feature('mrv1').selection('keepvtx').set('ige1(1)', [3]);
model.geom('geom1').feature('mrv1').selection('removevtx').set('ige1(1)', [2]);
model.geom('geom1').feature('cle1').selection('input').set('mrv1(1)', [57 59]);
model.geom('geom1').feature('mre1').selection('keepedg').set('cle1(1)', [50]);
model.geom('geom1').feature('mre1').selection('removeedg').set('cle1(1)', [51]);
model.geom('geom1').run;

model.view.create('view2', 2);
model.view.create('view3', 2);
model.view.create('view4', 2);
model.view.create('view5', 2);

model.material.create('mat1');

model.physics.create('solid', 'SolidMechanics', 'geom1');
model.physics('solid').feature.create('fix1', 'Fixed', 2);
model.physics('solid').feature('fix1').selection.set([8 9]);
model.physics('solid').feature.create('pl1', 'PointLoad', 0);
model.physics('solid').feature('pl1').selection.set([18]);

model.mesh.create('mesh1', 'geom1');
model.mesh('mesh1').feature.create('ftri1', 'FreeTri');
model.mesh('mesh1').feature.create('ftet1', 'FreeTet');
model.mesh('mesh1').feature('ftri1').selection.all;

model.result.table.create('evl2', 'Table');

model.view('view2').axis.set('xmin', '-0.3855358958244324');
model.view('view2').axis.set('ymin', '-0.8833182454109192');
model.view('view2').axis.set('xmax', '0.3949105739593506');
model.view('view2').axis.set('ymax', '-0.08417844772338867');
model.view('view3').axis.set('xmin', '-0.027907054871320724');
model.view('view3').axis.set('ymin', '-0.022213172167539597');
model.view('view3').axis.set('xmax', '0.0460403673350811');
model.view('view3').axis.set('ymax', '0.02026725932955742');
model.view('view4').axis.set('xmin', '-0.8739716410636902');
model.view('view4').axis.set('ymin', '-0.2241707295179367');
model.view('view4').axis.set('xmax', '-0.09352511167526245');
model.view('view4').axis.set('ymax', '0.22417087852954865');
model.view('view5').axis.set('ymin', '-0.3348327875137329');
model.view('view5').axis.set('ymax', '0.322141170501709');
model.view('view5').axis.set('xmin', '-0.07986076176166534');
model.view('view5').axis.set('xmax', '0.7115815877914429');

model.material('mat1').name('nylon 66 glass fiber 50%');
model.material('mat1').propertyGroup('def').set('density', '1600');
model.material('mat1').propertyGroup('def').set('youngsmodulus', '15200e6');
model.material('mat1').propertyGroup('def').set('poissonsratio', '.35');

model.physics('solid').feature('lemm1').set('minput_strainreferencetemperature', '0');
model.physics('solid').feature('pl1').set('Fp', {'0'; '-100'; '0'});

model.mesh('mesh1').feature('size').set('hauto', 4);
model.mesh('mesh1').feature('ftri1').active(false);
model.mesh('mesh1').run;

model.result.table('evl2').name('Evaluation 2D');
model.result.table('evl2').comments('Interactive 2D values');

model.study.create('std1');
model.study('std1').feature.create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').feature.create('st1', 'StudyStep');
model.sol('sol1').feature.create('v1', 'Variables');
model.sol('sol1').feature.create('s1', 'Stationary');
model.sol('sol1').feature('s1').feature.create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.study('std1').feature('stat').set('initstudyhide', 'on');
model.study('std1').feature('stat').set('initsolhide', 'on');
model.study('std1').feature('stat').set('notstudyhide', 'on');
model.study('std1').feature('stat').set('notsolhide', 'on');

model.result.dataset.create('mesh1', 'Mesh');
model.result.dataset.create('cpl1', 'CutPlane');
model.result.create('pg3', 'PlotGroup3D');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg3').feature.create('surf1', 'Surface');
model.result('pg3').feature('surf1').feature.create('def', 'Deform');
model.result('pg5').feature.create('line1', 'Line');
model.result.export.create('plot1', 'Plot');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').name('Compile Equations: Stationary');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').feature('s1').set('control', 'stat');
model.sol('sol1').runAll;

model.result.dataset('cpl1').set('genparadist', '.037');
model.result.dataset('cpl1').set('genparaactive', 'on');
model.result('pg3').name('Strain1 (solid)');
model.result('pg3').feature('surf1').set('expr', 'solid.ep1');
model.result('pg3').feature('surf1').set('unit', '1');
model.result('pg3').feature('surf1').set('descr', 'First principal strain');
model.result('pg3').feature('surf1').feature('def').set('scale', '0.14649165672089082');
model.result('pg3').feature('surf1').feature('def').set('scaleactive', false);
model.result('pg5').feature('line1').set('data', 'cpl1');
model.result('pg5').feature('line1').set('expr', 'solid.ep1');
model.result('pg5').feature('line1').set('unit', '1');
model.result('pg5').feature('line1').set('descr', 'First principal strain');
model.result.export('plot1').name('Strain1');
model.result.export('plot1').set('plotgroup', 'pg5');
model.result('pg5').set('window', 'graphics');
model.result('pg5').run;
model.result('pg5').set('window', 'graphics');
model.result('pg5').set('windowtitle', '');
model.result.export('plot1').set('filename', 'strain1.csv');
model.result.export('plot1').run;

out = model;
