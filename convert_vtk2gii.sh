#!/bin/bash

surfaces=${1}
prf_surfs=${2}

mris_convert ${surfaces}/lh.white.vtk ${surfaces}/lh.white.gii
mris_convert ${surfaces}/rh.white.vtk ${surfaces}/rh.white.gii
mris_convert ${surfaces}/lh.pial.vtk ${surfaces}/lh.pial.gii
mris_convert ${surfaces}/rh.pial.vtk ${surfaces}/rh.pial.gii
mris_convert ${surfaces}/lh.inflated.vtk ${surfaces}/lh.inflated.gii
mris_convert ${surfaces}/rh.inflated.vtk ${surfaces}/rh.inflated.gii
[[ -f ${surfaces}/lh.sphere.vtk ]] && mris_convert ${surfaces}/lh.sphere.vtk ${surfaces}/lh.sphere.gii
[[ -f ${surfaces}/rh.sphere.vtk ]] && mris_convert ${surfaces}/rh.sphere.vtk ${surfaces}/rh.sphere.gii
[[ -f ${surfaces}/lh.sphere.reg.vtk ]] && mris_convert ${surfaces}/lh.sphere.reg.vtk ${surfaces}/lh.sphere.reg.gii
[[ -f ${surfaces}/rh.sphere.reg.vtk ]] && mris_convert ${surfaces}/rh.sphere.reg.vtk ${surfaces}/rh.sphere.reg.gii

# also want white and sphere surfaces in FS format
mris_convert ${surfaces}/lh.white.vtk ${surfaces}/lh.white
mris_convert ${surfaces}/rh.white.vtk ${surfaces}/rh.white
[[ -f ${surfaces}/lh.sphere.vtk ]] && mris_convert ${surfaces}/lh.sphere.vtk ${surfaces}/lh.sphere
[[ -f ${surfaces}/rh.sphere.vtk ]] && mris_convert ${surfaces}/rh.sphere.vtk ${surfaces}/rh.sphere
[[ -f ${surfaces}/lh.sphere.reg.vtk ]] && mris_convert ${surfaces}/lh.sphere.reg.vtk ${surfaces}/lh.sphere.reg
[[ -f ${surfaces}/rh.sphere.reg.vtk ]] && mris_convert ${surfaces}/rh.sphere.reg.vtk ${surfaces}/rh.sphere.reg

