[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.245-blue.svg)](https://doi.org/10.25663/brainlife.app.245)

# app-bayesian-retinotopy

This app computes retinotopic maps on visual cortex surface using both measured retinotopic data and an anatomical prior, following [Benson & Winawer 2018](https://elifesciences.org/articles/40224) and using Noah Benson's [neuropythy library](github.com/noahbenson/neuropythy).


Because retinotopic maps in human visual cortex are expected to be spatially smooth, fitting maps using voxel-wise measurements alone introduces noise into the outputted pRF parameters that can be at least partially regressed out by considering each voxel within the context of the entire visual field and the corresponding cortex. Retinotopic maps have been shown to be well predicted by gyral and sulcal topology, and so a group-derived algebraic template can be fit to a subject's anatomy and used as a prior when fitting fMRI measurements. By using both measured, voxel-wise fMRI data collected during a retinotopic task and an anatomical atlas as a prior, the retinotopic maps derived are more accurate than those derived from either data alone or anatomy alone [Benson et al, 2018](10.7554/eLife.40224).

pRF measures include:
  polar angle: the location of the receptive field in polar coordinates (from the upper vertical meridian at 0° to the lower vertical meridian at 180°)
  eccentricity: the deviation of the center of the receptive field from the fovea (in degrees)
  receptive field width: the size of the voxel's receptive field (the standard deviation of the receptive field's 2d isotropic Gaussian)
  visual area: the voxel's predicted visual area (1-12, key found in ./varea/key.txt)

![prf_measures](prf_measures.jpg)
Shows maps in several visual areas of polar angle, left, and eccentricity, right

![screen](screen.png)
Visualized on Brainlife

### Authors
- [David Hunt](davhunt@iu.edu)
- [Noah Benson](nben@nyu.edu)

### Project director
- Franco Pestilli (franpest@indiana.edu)

### Funding Acknowledgement
brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

## Running the App 

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/brainlife.app.245](https://doi.org/10.25663/brainlife.app.245) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with path to your freesurfer subject directory.

```json
{
        "prf_surfs": "./prf/prf_surfaces"
        "freesurfer": "./freesurfer/subjects/bert"
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Sample Datasets

If you don't have your own freesurfer and prf data, you can download sample datasets from Brainlife.io, or you can use [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 598a2aa44258600aa3128fd4 && mv -R 598a2aa44258600aa3128fd4 input/output
bl dataset download 5daf6a1455718d57f377472b && mv -R 5daf6a1455718d57f377472b input/prf
```

## Output

All output files will be generated under the current working directory (pwd). The main output of this App is the directory `prf`, which contains the population receptive field measures polarAngle, eccentricity, rfWidth, and varea in the brain volume (*.nii.gz) as well as on the cortical surface (lh.polarAngle, etc) in freesurfer .curv format and gifti format.

```
    .
    ├── prf                     # Contains all pRF measures
    │   ├── polarAngle.nii.gz
    │   ├── eccentricity.nii.gz
    │   ├── rfWidth.nii.gz
    │   ├── varea.nii.gz
    │   ├── surfaces            # White, pial, inflated, and sphere surfaces in .vtk
    │   │   ├── lh.white.vtk
    │   │   ├── rh.white.vtk
    │   │   ├── ...
    │   ├── prf_surfaces        # pRF measures projected onto .vtk surfaces
    │   │   ├── lh.polarAngle
    │   │   ├── rh.polarAngle
    │   │   ├── ...
    ├── varea                   # Volumetric parcellation of brain into visual areas
    │   ├── key.txt
    │   ├── label.json
    │   ├── parc.nii.gz
    ├── varea_surf              # Surface/cortical parcellation into visual areas
    │   ├── key.txt
    │   ├── label.json
    │   ├── lh.parc.annot.gii
    └   └── rh.parc.annot.gii
```

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run.

### Citations
We kindly ask that you cite the following articles when publishing papers and code using this code. 

1. Benson, N. C., Butt, O. H., Datta, R., Radoeva, P. D., Brainard, D. H., & Aguirre, G. K. (2012). The retinotopic organization of striate cortex is well predicted by surface topology. Current Biology, 22(21), 2081-2085. [https://doi.org/10.1016/j.cub.2012.09.014](https://doi.org/10.1016/j.cub.2012.09.014)

2. Benson, N. C., Butt, O. H., Brainard, D. H., & Aguirre, G. K. (2014). Correction of distortion in flattened representations of the cortical surface allows prediction of V1-V3 functional organization from anatomy. PLoS Comput Biol, 10(3), e1003538. [https://doi.org/10.1371/journal.https://doi.org/10.1371/journal.pcbi.1003538pcbi.1003538](https://doi.org/10.1371/journal.pcbi.1003538)

3. Benson, N. C., & Winawer, J. (2018). Bayesian analysis of retinotopic maps. elife, 7, e40224. [https://doi.org/10.7554/eLife.40224](https://doi.org/10.7554/eLife.40224)

4. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [https://doi.org/10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

#### MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University
