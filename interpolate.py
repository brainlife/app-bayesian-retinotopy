#!/usr/bin/env python

import nibabel as nib
import nibabel.freesurfer.io as fsio
import os
import neuropythy as ny
import json

from scipy.io import loadmat

with open('config.json') as config_json:
    config = json.load(config_json)
fs_dir = './' + os.path.basename(config['output'])
prf_surfs = config['prf_surfs']

giftis = loadmat('./saved_giftis.mat')

# write the freesurfer-format surface files into the MNI-space FS directory
fsio.write_geometry(fs_dir + '_MNI/surf/rh.sphere.reg', giftis['rhSphereRegCoords'], giftis['rhSphereRegFaces'])
fsio.write_geometry(fs_dir + '_MNI/surf/lh.sphere.reg', giftis['lhSphereRegCoords'], giftis['lhSphereRegFaces'])
fsio.write_geometry(fs_dir + '_MNI/surf/rh.white', giftis['rhWhiteCoords'], giftis['rhWhiteFaces'])
fsio.write_geometry(fs_dir + '_MNI/surf/lh.white', giftis['lhWhiteCoords'], giftis['lhWhiteFaces'])

# load MNI-space pRF parameter surfaces

rh_eccentricity = fsio.read_morph_data(prf_surfs + '/rh.benson14_eccentricity')
rh_r2 = fsio.read_morph_data(prf_surfs + '/rh.benson14_r2')
rh_rfWidth = fsio.read_morph_data(prf_surfs + '/rh.benson14_rfWidth')
rh_polarAngle = fsio.read_morph_data(prf_surfs + '/rh.benson14_polarAngle')
lh_eccentricity = fsio.read_morph_data(prf_surfs + '/lh.benson14_eccentricity')
lh_r2 = fsio.read_morph_data(prf_surfs + '/lh.benson14_r2')
lh_rfWidth = fsio.read_morph_data(prf_surfs + '/lh.benson14_rfWidth')
lh_polarAngle = fsio.read_morph_data(prf_surfs + '/lh.benson14_polarAngle')



native_sub = ny.freesurfer_subject(os.path.basename(fs_dir)) # cortex object in original subject space
prf_sub = ny.freesurfer_subject(os.path.basename(fs_dir) + '_MNI') #cortex object with prf measurements in MNI space

new_lh = prf_sub.lh
new_lh = new_lh.with_prop(eccentricity=lh_eccentricity, r2=lh_r2, rfWidth=lh_rfWidth, polarAngle=lh_polarAngle)

new_rh = prf_sub.rh
new_rh = new_rh.with_prop(eccentricity=rh_eccentricity, r2=rh_r2, rfWidth=rh_rfWidth, polarAngle=rh_polarAngle)

#for hemi in ['rh' 'lh']:
for i in ['eccentricity', 'r2', 'rfWidth', 'polarAngle']:
    prf_interpolated_lh = new_lh.interpolate(native_sub.lh, prf_sub.lh.prop(i), method='linear')
    prf_interpolated_rh = new_rh.interpolate(native_sub.rh, prf_sub.rh.prop(i), method='linear')
    #fsio.write_morph_data('./interpolated_prf_surfs/' + hemi + '.' + i, prf_interpolated)
    #fsio.write_morph_data('./interpolated_prf_surfs/' + hemi + '.' + i, prf_interpolated)




    fsio.write_morph_data('./interpolated_prf_surfs/lh.benson14_' + i, prf_interpolated_lh)
    fsio.write_morph_data('./interpolated_prf_surfs/rh.benson14_' + i, prf_interpolated_rh)

