#!/usr/bin/env python

import nibabel as nib
import nibabel.freesurfer.io as fsio
import sys

prf_surfs = sys.argv[1]

#mris_convert ${prf_surfs}/lh.r2.gii ${prf_surfs}/lh.r2
#mris_convert ${prf_surfs}/rh.r2.gii ${prf_surfs}/rh.r2
#mris_convert ${prf_surfs}/lh.polarAngle.gii ${prf_surfs}/lh.polarAngle
#mris_convert ${prf_surfs}/rh.polarAngle.gii ${prf_surfs}/rh.polarAngle
#mris_convert ${prf_surfs}/lh.rfWidth.gii ${prf_surfs}/lh.rfWidth
#mris_convert ${prf_surfs}/rh.rfWidth.gii ${prf_surfs}/rh.rfWidth
#mris_convert ${prf_surfs}/lh.eccentricity.gii ${prf_surfs}/lh.eccentricity
#mris_convert ${prf_surfs}/rh.eccentricity.gii ${prf_surfs}/rh.eccentricity

for i in ['r2', 'polarAngle', 'rfWidth', 'eccentricity']:
  lh_gifti = nib.load(prf_surfs + '/lh.' + i + '.gii')
  fsio.write_morph_data(prf_surfs + '/lh.' + i, lh_gifti.darrays[0].data)
  rh_gifti = nib.load(prf_surfs + '/rh.' + i + '.gii')
  fsio.write_morph_data(prf_surfs + '/rh.' + i, rh_gifti.darrays[0].data)
