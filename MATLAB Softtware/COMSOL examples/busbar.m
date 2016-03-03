model = ModelUtil.create('Model');

% Set parameters
model.param.set('L','9[cm]','Length of the busbar');
model.param.set('rad_1','6[mm]','Radius of the fillet');
model.param.set('tbb','5[mm]','Thickness');
model.param.set('wbb','5[cm]','Width');
model.param.set('mh','6[mm]','Maximum element size');
model.param.set('htc','5[W/m^2/K]','Heat transfer coefficient');
model.param.set('Vtot','20[mV]','Applied electric potential');

% Build geometry
geom1 = model.geom.create('geom1',3);
wp1 = geom1.feature.create('wp1','WorkPlane');
wp1.set('quickplane','xz');
r1 = wp1.geom.feature.create('r1','Rectangle');
r1.set('size',{'L+2*tbb' '0.1'});
r2 = wp1.geom.feature.create('r2','Rectangle');
r2.set('size',{'L+tbb' '0.1-tbb'});
r2.set('pos',{'0' 'tbb'});
dif1 = wp1.geom.feature.create('dif1','Difference');
dif1.selection('input').set({'r1'});
dif1.selection('input2').set({'r2'});

% Display progress
mphgeom(model,'geom1');

% Round corners and extrude plane
 fil1 = wp1.geom.feature.create('fil1','Fillet');
fil1.selection('point').set('dif1(1)',3);
fil1.set('radius','tbb');
fil2 = wp1.geom.feature.create('fil2','Fillet');
fil2.selection('point').set('fil1(1)',6);
fil2.set('radius','2*tbb');
ext1 = geom1.feature.create('ext1','Extrude');
ext1.selection('input').set({'wp1'});
ext1.set('distance',{'wbb'});

% Display progress
mphgeom(model)

% Create bolts
wp2 = geom1.feature.create('wp2','WorkPlane');
wp2.set('planetype','faceparallel');
wp2.selection('face').set('ext1(1)',8);
c1 = wp2.geom.feature.create('c1','Circle');
c1.set('r','rad_1');
ext2 = geom1.feature.create('ext2','Extrude');
ext2.selection('input').set({'wp2'});
ext2.set('distance',{'-2*tbb'});
wp3 = geom1.feature.create('wp3','WorkPlane');
wp3.set('planetype','faceparallel');
wp3.selection('face').set('ext1(1)',4);
c2 = wp3.geom.feature.create('c2','Circle');
c2.set('r','rad_1');
c2.set('pos',{'-L/2+1.5e-2' '-wbb/4'});
copy1 = wp3.geom.feature.create('copy1','Copy');
copy1.selection('input').set({'c2'});
copy1.set('disply','wbb/2');
ext3 = geom1.feature.create('ext3','Extrude');
ext3.selection('input').set({'wp3.c2' 'wp3.copy1'});
ext3.set('distance',{'-2*tbb'});

% Build geometry
geom1.run;

% Display finished geometry
mphgeom(model)

% Create selection item for titanium bolts ('Ti bolts')
sel1 = model.selection.create('sel1');
sel1.set([2 3 4 5 6 7]);
sel1.name('Ti bolts');

% Create materials (copper and titanium)
mat1 = model.material.create('mat1');
mat1.materialModel('def').set('electricconductivity',{'5.998e7[S/m]'});
mat1.materialModel('def').set('heatcapacity',{'385[J/(kg*K)]'});
mat1.materialModel('def').set('relpermittivity',{'1'});
mat1.materialModel('def').set('density',{'8700[kg/m^3]'});
mat1.materialModel('def').set('thermalconductivity',{'400[W/(m*K)]'});
mat1.name('Copper');

mat2 = model.material.create('mat2');
mat2.materialModel('def').set('electricconductivity',{'7.407e5[S/m]'});
mat2.materialModel('def').set('heatcapacity',{'710[J/(kg*K)]'});
mat2.materialModel('def').set('relpermittivity',{'1'});
mat2.materialModel('def').set('density',{'4940[kg/m^3]'});
mat2.materialModel('def').set('thermalconductivity',{'7.5[W/(m*K)]'});
mat2.name('Titanium');

% Assign mat2 to sel1 ('Ti bolts') - copper is default selection elsewhere
mat2.selection.named('sel1');

% Set up physics (JouleHeating)
jh = model.physics.create('jh','JouleHeating','geom1');
hf1 = jh.feature.create('hf1','HeatFluxBoundary',2);
hf1.set('HeatFluxType','InwardHeatFlux');
hf1.selection.set([1:7 9:14 16:42]);
hf1.set('h','htc');

% Display geometry with face labels (used to select boundaries)
mphgeom(model,'geom1','facemode','off','facelabels','on')

% Continue adding boundary conditions
pot1 = jh.feature.create('pot1','ElectricPotential',2);
pot1.selection.set([43]);
pot1.set('V0','Vtot');
gnd1 = jh.feature.create('gnd1','Ground',2);
gnd1.selection.set([8 15]);

% Create free tetrahedral mesh
mesh1 = model.mesh.create('mesh1','geom1');
size = mesh1.feature('size');
size.set('hmax','mh');
size.set('hmin','mh-mh/3');
size.set('hcurve','0.2');
ftet1 = mesh1.feature.create('ftet1','FreeTet');

% Build mesh
mesh1.run;

% Display mesh
mphmesh(model)

% Create stationary study
std1 = model.study.create('std1');
stat = std1.feature.create('stat','Stationary');

% Display progress bar
% ModelUtil.showProgress(true)
% Progress bar display is not supported on Mac OS X.

% Solve model
std1.run;

% Plot results
pg1 = model.result.create('pg1','PlotGroup3D');
pg1.feature.create('surf1','Surface');
pg1.feature('surf1').set('rangecoloractive','on');
pg1.feature('surf1').set('rangecolormin','322.6');
pg1.feature('surf1').set('rangecolormax','323.3');
mphplot(model,'pg1','rangenum',1)

% Add second plot
figure;
pg2 = model.result.create('pg2','PlotGroup3D');
pg2.feature.create('surf1','Surface');
pg2.feature('surf1').set('expr','jh.normJ');
pg2.feature('surf1').set('rangecoloractive','on');
pg2.feature('surf1').set('rangecolormax','1e6');
pg2.set('title','Current density norm (A/m^2)');
mphplot(model,'pg2','rangenum',1)

% Export temperature data to file
data1 = model.result.export.create('data1','Data');
data1.setIndex('expr','T',0);
data1.set('filename','Temperature.txt');
data1.run;

