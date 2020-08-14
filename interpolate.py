#!/usr/bin/env python

import numpy as np
import nibabel as nib
import nibabel.freesurfer.io as fsio
import os
import shutil
import sys
import json
import neuropythy as ny

#from scipy.io import loadmat

with open('config.json') as config_json:
    config = json.load(config_json)
fs_dir = './' + os.path.basename(config['output'])
prf_surfs = config['prf_surfs']
surfaces = config['surfaces']

#giftis = loadmat('./saved_giftis.mat')

# check that #vertices in Freesurfer surfaces are the same as prf surfaces
num_vertices_gifti_rh = nib.load(prf_surfs + '/rh.r2.gii').darrays[0].data.shape[0]
num_vertices_gifti_lh = nib.load(prf_surfs + '/lh.r2.gii').darrays[0].data.shape[0]
num_vertices_fs_rh = fsio.read_geometry(fs_dir + '/surf/rh.white')[0].shape[0]
num_vertices_fs_lh = fsio.read_geometry(fs_dir + '/surf/lh.white')[0].shape[0]

if num_vertices_gifti_rh != num_vertices_fs_rh or num_vertices_gifti_lh != num_vertices_fs_lh:
  if os.path.isfile(surfaces + '/rh.sphere.reg') and os.path.isfile(surfaces + '/lh.sphere.reg'):
    shutil.copyfile(surfaces + '/rh.sphere.reg', fs_dir + '_prf_space/surf/rh.sphere.reg')
    shutil.copyfile(surfaces + '/lh.sphere.reg', fs_dir + '_prf_space/surf/lh.sphere.reg')
  elif os.path.isfile(surfaces + '/rh.sphere') and os.path.isfile(surfaces + '/lh.sphere'):
    shutil.copyfile(surfaces + '/rh.sphere', fs_dir + '_prf_space/surf/rh.sphere.reg')
    shutil.copyfile(surfaces + '/lh.sphere', fs_dir + '_prf_space/surf/lh.sphere.reg')
  else:
    sys.exit('must have rh/lh.sphere.reg or rh/lh.sphere surfaces to interpolate from PRF surface space to FS surface space')

  if os.path.isfile(surfaces + '/rh.white') and os.path.isfile(surfaces + '/lh.white'):
    shutil.copyfile(surfaces + '/rh.white', fs_dir + '_prf_space/surf/rh.white')
    shutil.copyfile(surfaces + '/lh.white', fs_dir + '_prf_space/surf/lh.white')
  else:
    sys.exit('can\'t find rh.white and lh.white surfaces in PRF input')

  rh_eccentricity = fsio.read_morph_data(prf_surfs + '/rh.eccentricity')
  rh_r2 = fsio.read_morph_data(prf_surfs + '/rh.r2')
  rh_rfWidth = fsio.read_morph_data(prf_surfs + '/rh.rfWidth')
  rh_polarAngle = fsio.read_morph_data(prf_surfs + '/rh.polarAngle')
  lh_eccentricity = fsio.read_morph_data(prf_surfs + '/lh.eccentricity')
  lh_r2 = fsio.read_morph_data(prf_surfs + '/lh.r2')
  lh_rfWidth = fsio.read_morph_data(prf_surfs + '/lh.rfWidth')
  lh_polarAngle = fsio.read_morph_data(prf_surfs + '/lh.polarAngle')

  native_sub = ny.freesurfer_subject(os.path.basename(fs_dir)) # cortex object in original subject space
  prf_sub = ny.freesurfer_subject(os.path.basename(fs_dir) + '_prf_space') #cortex object with prf measurements  in MNI space

  new_lh = prf_sub.lh
  new_lh = new_lh.with_prop(eccentricity=lh_eccentricity, r2=lh_r2, rfWidth=lh_rfWidth, polarAngle=lh_polarAngle)

  new_rh = prf_sub.rh
  new_rh = new_rh.with_prop(eccentricity=rh_eccentricity, r2=rh_r2, rfWidth=rh_rfWidth, polarAngle=rh_polarAngle)

  for i in ['eccentricity', 'r2', 'rfWidth', 'polarAngle']:
    prf_interpolated_lh = new_lh.interpolate(native_sub.lh, new_lh.prop(i), method='linear')
    prf_interpolated_rh = new_rh.interpolate(native_sub.rh, new_rh.prop(i), method='linear')

    fsio.write_morph_data('./interpolated_prf_surfs/lh.' + i, prf_interpolated_lh)
    fsio.write_morph_data('./interpolated_prf_surfs/rh.' + i, prf_interpolated_rh)

else: # no interpolation needed
  for i in ['eccentricity', 'r2', 'rfWidth', 'polarAngle']:
    shutil.copyfile(prf_surfs + '/rh.' + i, './interpolated_prf_surfs/rh.' + i)
    shutil.copyfile(prf_surfs + '/lh.' + i, './interpolated_prf_surfs/lh.' + i)


