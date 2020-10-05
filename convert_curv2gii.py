#!/usr/bin/env python

import numpy as np
import nibabel as nib
import nibabel.freesurfer.io as fsio

rh_eccentricity = fsio.read_morph_data('./prf/prf_surfaces/rh.eccentricity')
rh_rfWidth = fsio.read_morph_data('./prf/prf_surfaces/rh.rfWidth')
rh_polarAngle = fsio.read_morph_data('./prf/prf_surfaces/rh.polarAngle')
rh_varea = fsio.read_morph_data('./prf/prf_surfaces/rh.varea')
rh_r2 = fsio.read_morph_data('./prf/prf_surfaces/rh.r2')
lh_eccentricity = fsio.read_morph_data('./prf/prf_surfaces/lh.eccentricity')
lh_rfWidth = fsio.read_morph_data('./prf/prf_surfaces/lh.rfWidth')
lh_polarAngle = fsio.read_morph_data('./prf/prf_surfaces/lh.polarAngle')
lh_varea = fsio.read_morph_data('./prf/prf_surfaces/lh.varea')
lh_r2 = fsio.read_morph_data('./prf/prf_surfaces/lh.r2')

darrays = [None]

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=rh_eccentricity)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/rh.eccentricity.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=rh_rfWidth)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/rh.rfWidth.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=rh_polarAngle)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/rh.polarAngle.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=rh_varea)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/rh.varea.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=rh_r2)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/rh.r2.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=lh_eccentricity)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/lh.eccentricity.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=lh_rfWidth)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/lh.rfWidth.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=lh_polarAngle)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/lh.polarAngle.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=lh_varea)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/lh.varea.gii')

darrays[0] = nib.gifti.gifti.GiftiDataArray(data=lh_r2)
gii = nib.gifti.gifti.GiftiImage(darrays=darrays)
nib.gifti.giftiio.write(gii,'./prf/prf_surfaces/lh.r2.gii')

