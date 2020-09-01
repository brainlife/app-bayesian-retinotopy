#!/bin/bash

surfaces=${1}
prf_surfs=${2}

mris_convert ${surfaces}/lh.white.vtk ${surfaces}/lh.white.gii
mris_convert ${surfaces}/rh.white.vtk ${surfaces}/rh.white.gii
mris_convert ${surfaces}/lh.pial.vtk ${surfaces}/lh.pial.gii
mris_convert ${surfaces}/rh.pial.vtk ${surfaces}/rh.pial.gii
mris_convert ${surfaces}/lh.inflated.vtk ${surfaces}/lh.inflated.gii
mris_convert ${surfaces}/rh.inflated.vtk ${surfaces}/rh.inflated.gii
mris_convert ${surfaces}/lh.sphere.vtk ${surfaces}/lh.sphere.gii
mris_convert ${surfaces}/rh.sphere.vtk ${surfaces}/rh.sphere.gii
mris_convert ${surfaces}/lh.sphere.reg.vtk ${surfaces}/lh.sphere.reg.gii
mris_convert ${surfaces}/rh.sphere.reg.vtk ${surfaces}/rh.sphere.reg.gii

# also want white and sphere surfaces in FS-curv format
mris_convert ${surfaces}/lh.white.vtk ${surfaces}/lh.white
mris_convert ${surfaces}/rh.white.vtk ${surfaces}/rh.white
mris_convert ${surfaces}/lh.sphere.vtk ${surfaces}/lh.sphere
mris_convert ${surfaces}/rh.sphere.vtk ${surfaces}/rh.sphere
mris_convert ${surfaces}/lh.sphere.reg.vtk ${surfaces}/lh.sphere.reg
mris_convert ${surfaces}/rh.sphere.reg.vtk ${surfaces}/rh.sphere.reg

# prf measures also in FS-curv format

#mris_convert ${prf_surfs}/lh.r2.gii ${prf_surfs}/lh.r2
#mris_convert ${prf_surfs}/rh.r2.gii ${prf_surfs}/rh.r2
#mris_convert ${prf_surfs}/lh.polarAngle.gii ${prf_surfs}/lh.polarAngle
#mris_convert ${prf_surfs}/rh.polarAngle.gii ${prf_surfs}/rh.polarAngle
#mris_convert ${prf_surfs}/lh.rfWidth.gii ${prf_surfs}/lh.rfWidth
#mris_convert ${prf_surfs}/rh.rfWidth.gii ${prf_surfs}/rh.rfWidth
#mris_convert ${prf_surfs}/lh.eccentricity.gii ${prf_surfs}/lh.eccentricity
#mris_convert ${prf_surfs}/rh.eccentricity.gii ${prf_surfs}/rh.eccentricity

