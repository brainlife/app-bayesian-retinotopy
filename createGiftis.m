function createSurfs()

load('./prf/prf_surfs.mat');

gii = gifti;
gii.cdata = rh_eccentricity';
save_gifti(gii,'./prf/benson14_surfaces/rh.eccentricity.gii');

gii = gifti;
gii.cdata = rh_rfWidth';
save_gifti(gii,'./prf/benson14_surfaces/rh.rfWidth.gii');

gii = gifti;
gii.cdata = rh_polarAngle';
save_gifti(gii,'./prf/benson14_surfaces/rh.polarAngle');

gii = gifti;
gii.cdata = rh_varea';
save_gifti(gii,'./prf/benson14_surfaces/rh.varea');

gii = gifti;
gii.cdata = rh_r2';
save_gifti(gii,'./prf/benson14_surfaes/rh.r2');

gii = gifti;
gii.cdata = lh_eccentricity';
save_gifti(gii,'./prf/benson14_surfaces/lh.eccentricity.gii');

gii = gifti;
gii.cdata = lh_rfWidth';
save_gifti(gii,'./prf/benson14_surfaces/lh.rfWidth.gii');

gii = gifti;
gii.cdata = lh_polarAngle';
save_gifti(gii,'./prf/benson14_surfaces/lh.polarAngle');

gii = gifti;
gii.cdata = lh_varea';
save_gifti(gii,'./prf/benson14_surfaces/lh.varea');

gii = gifti;
gii.cdata = lh_r2';
save_gifti(gii,'./prf/benson14_surfaes/lh.r2');

end
