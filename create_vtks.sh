#!/bin/bash

fsdir=${1}

echo "converting output to nifti"
for i in ${fsdir}/mri/*inferred*
do 
	mri_convert $i ${i%.*}.nii.gz
done

echo "organizing output"
mv ${fsdir}/surf/*inferred* prf/prf_surfaces
mv ${fsdir}/mri/*inferred*.nii.gz prf

mv prf/inferred_eccen.nii.gz prf/eccentricity.nii.gz 
mv prf/inferred_sigma.nii.gz prf/rfWidth.nii.gz 
mv prf/inferred_angle.nii.gz prf/polarAngle.nii.gz 
mv prf/inferred_varea.nii.gz prf/varea.nii.gz 
cp prf/varea.nii.gz varea/parc.nii.gz

for i in rh lh
do
  mv prf/prf_surfaces/${i}.inferred_eccen prf/prf_surfaces/${i}.eccentricity
  mv prf/prf_surfaces/${i}.inferred_sigma prf/prf_surfaces/${i}.rfWidth
  mv prf/prf_surfaces/${i}.inferred_angle prf/prf_surfaces/${i}.polarAngle
  mv prf/prf_surfaces/${i}.inferred_varea prf/prf_surfaces/${i}.varea
  cp prf/prf_surfaces/${i}.varea varea_surf/${i}.parc.annot
done

echo "creating vtks"
mkdir -p prf/surfaces
for hemi in lh rh; do
  for surf in white pial sphere inflated; do
    mris_convert --to-scanner $fsdir/surf/${hemi}.${surf} prf/surfaces/${hemi}.${surf}.vtk
    mris_convert --to-scanner $fsdir/surf/${hemi}.${surf} prf/surfaces/${hemi}.${surf}.gii
    mris_convert --to-scanner $fsdir/surf/${hemi}.${surf} varea_surf/${hemi}.parc.${surf}.gii
  done
done
