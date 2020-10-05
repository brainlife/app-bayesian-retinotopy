#!/usr/bin/env python

import numpy as np
import nibabel as nib
import nibabel.freesurfer.io as fsio
import os
import sys

img = nib.load('varea/parc.nii.gz')
data = img.get_fdata()

for i in range(data.shape[0]):
  for j in range(data.shape[1]):
    for k in range(data.shape[2]):
      if data[i,j,k] >= 1:
        data[i,j,k] = 1
out_vol = nib.Nifti1Image(data, img.affine)
nib.save(out_vol, os.path.join(os.getcwd(),'prf','r2.nii.gz'))

data = fsio.read_morph_data('varea_surf/rh.parc.annot')
#data = fsio.read_morph_data('varea_surf/rh.parc.annot')
for i in range(data.shape[0]):
  if data[i] >= 1:
    data[i] = 1
fsio.write_morph_data(os.path.join(os.getcwd(),'prf','prf_surfaces','rh.r2'),data)

data = fsio.read_morph_data('varea_surf/lh.parc.annot')
#data = fsio.read_morph_data('varea_surf/lh.parc.annot')
for i in range(data.shape[0]):
  if data[i] >= 1:
    data[i] = 1
fsio.write_morph_data(os.path.join(os.getcwd(),'prf','prf_surfaces','lh.r2'),data)
