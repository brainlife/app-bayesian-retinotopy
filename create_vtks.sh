#!/bin/bash

fsdir=${1}

echo "converting output to nifti"
for i in ./ret_output/$(basename $fsdir)/mri/*inferred*
do 
	mri_convert $i ${i%.*}.nii.gz
done

echo "organizing output"
mv ./ret_output/$(basename $fsdir)/surf/*inferred* prf/benson14_surfaces
mv ./ret_output/$(basename $fsdir)/mri/*inferred*.nii.gz prf


mv prf/inferred_eccen.nii.gz prf/eccentricity.nii.gz 
mv prf/inferred_sigma.nii.gz prf/rfWidth.nii.gz 
mv prf/inferred_angle.nii.gz prf/polarAngle.nii.gz 
mv prf/inferred_varea.nii.gz prf/varea.nii.gz 
cp prf/varea.nii.gz varea/parc.nii.gz

for i in rh lh
do
  mv prf/benson14_surfaces/${i}.inferred_eccen prf/benson14_surfaces/${i}.eccentricity
  mv prf/benson14_surfaces/${i}.inferred_sigma prf/benson14_surfaces/${i}.rfWidth
  mv prf/benson14_surfaces/${i}.inferred_angle prf/benson14_surfaces/${i}.polarAngle
  mv prf/benson14_surfaces/${i}.inferred_varea prf/benson14_surfaces/${i}.varea
done

echo "running create_R2"
# this will create a binary mask R2 of 1's and 0's
# based on whether a voxel is assigned a visual area or not
./create_R2.py ./varea/parc.nii.gz ./prf/benson14_surfaces/rh.varea ./prf/benson14_surfaces/lh.varea

echo "saving surfaces in .mat file"
./save_mat.py


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
