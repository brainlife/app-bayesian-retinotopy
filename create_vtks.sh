#!/bin/bash

fsdir=${1}

echo "converting output to nifti"
for i in ./ret_output/$(basename $fsdir)/mri/*inferred*
do 
	mri_convert $i ${i%.*}.nii.gz
done

echo "organizing output"
mkdir -p prf/benson14_surfaces varea
mv ./ret_output/$(basename $fsdir)/surf/*inferred* prf/benson14_surfaces
mv ./ret_output/$(basename $fsdir)/mri/*inferred*.nii.gz prf

mv prf/inferred_eccen.nii.gz prf/eccentricity.nii.gz 
mv prf/inferred_sigma.nii.gz prf/rfWidth.nii.gz 
mv prf/inferred_angle.nii.gz prf/polarAngle.nii.gz 
mv prf/inferred_varea.nii.gz prf/varea.nii.gz 
cp prf/inferred_varea.nii.gz varea/parc.nii.gz

echo "creating vtks"
mkdir -p prf/surfaces
mris_convert --to-scanner $fsdir/surf/lh.white prf/surfaces/lh.white.vtk
mris_convert --to-scanner $fsdir/surf/rh.white prf/surfaces/rh.white.vtk
mris_convert --to-scanner $fsdir/surf/lh.pial prf/surfaces/lh.pial.vtk
mris_convert --to-scanner $fsdir/surf/rh.pial prf/surfaces/rh.pial.vtk
mris_convert --to-scanner $fsdir/surf/lh.sphere prf/surfaces/lh.sphere.vtk
mris_convert --to-scanner $fsdir/surf/rh.sphere prf/surfaces/rh.sphere.vtk
mris_convert --to-scanner $fsdir/surf/lh.inflated prf/surfaces/lh.inflated.vtk
mris_convert --to-scanner $fsdir/surf/rh.inflated prf/surfaces/rh.inflated.vtk
