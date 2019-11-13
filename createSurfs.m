function createSurfs()


lh_fsLR_fsaverage_reg = gifti('/N/u/davhunt/Carbonate/app-bayesian-retinotopy/resample_fsaverage/fs_LR-deformed_to-fsaverage.L.sphere.59k_fs_LR.surf.gii');
rh_fsLR_fsaverage_reg = gifti('/N/u/davhunt/Carbonate/app-bayesian-retinotopy/resample_fsaverage/fs_LR-deformed_to-fsaverage.R.sphere.59k_fs_LR.surf.gii');

lh_59k_atlas = gifti('/N/u/davhunt/Carbonate/Downloads/102816_hcp/102816_3T_Structural_1.6mm_preproc/MNINonLinear/fsaverage_LR59k/102816.L.atlasroi.59k_fs_LR.shape.gii');
rh_59k_atlas = gifti('/N/u/davhunt/Carbonate/Downloads/102816_hcp/102816_3T_Structural_1.6mm_preproc/MNINonLinear/fsaverage_LR59k/102816.R.atlasroi.59k_fs_LR.shape.gii');

lh_59k_white = gifti('/N/u/davhunt/Carbonate/Downloads/102816_hcp/102816_3T_Structural_1.6mm_preproc/MNINonLinear/fsaverage_LR59k/102816.L.white.59k_fs_LR.surf.gii');
rh_59k_white = gifti('/N/u/davhunt/Carbonate/Downloads/102816_hcp/102816_3T_Structural_1.6mm_preproc/MNINonLinear/fsaverage_LR59k/102816.R.white.59k_fs_LR.surf.gii');
% 59k GIFTIs in MNI space


bad_vertices_index = struct;
good_faces_bool = struct;
new_vertices = struct;
new_faces = struct;

for hemi = {'lh' 'rh'}
  for surf = {'_fsLR_fsaverage_reg' '_59k_white'}
%  for surf = {'_fsLR_fsaverage_reg' '_59k_white'}
    new_vertices.([char(hemi),char(surf)]) = [];
    %indices_lh = [];
    bad_vertices_index.(char(hemi)) = [];
    sphere = eval([char(hemi),char(surf)]);
    atlas = eval([char(hemi),'_59k_atlas']);
    for i=(1:size(atlas.cdata,1))
      if atlas.cdata(i,1) == 1
        idx = int2str(i);
        new_vertices.([char(hemi),char(surf)]) = [new_vertices.([char(hemi),char(surf)]); eval(['sphere.vertices(',idx,',:)'])];
      else
        bad_vertices_index.(char(hemi)) = [bad_vertices_index.(char(hemi)), i];
      end
    end
  end
end

for hemi = {'lh' 'rh'}
  sphere = eval([char(hemi),char(surf)]);
%  for surf = {'_fs_LR_fsaverage_reg' '_59k_white'}

    new_faces.(char(hemi)) = [];
    good_faces_bool.(char(hemi)) = [];
    for i=(1:size(sphere.faces,1))
      include_face = true;
      if ismember(sphere.faces(i,1),bad_vertices_index.(char(hemi))) || ismember(sphere.faces(i,2),bad_vertices_index.(char(hemi))) || ismember(sphere.faces(i,3),bad_vertices_index.(char(hemi)))
        include_face = false;
        %disp(i)
        good_faces_bool.(char(hemi)) = [good_faces_bool.(char(hemi)), 0];
      else
        idx = int2str(i);
        new_faces.(char(hemi)) = [new_faces.(char(hemi)); eval(['sphere.faces(',idx,',:)'])];
        good_faces_bool.(char(hemi)) = [good_faces_bool.(char(hemi)), 1];
      end
    end
  for surf = {'_fsLR_fsaverage_reg' '_59k_white'}

%for surf = {'_fsLR_fsaverage_reg' '_59k_white'}
    tmpgii = gifti;
    tmpgii.vertices = new_vertices.([char(hemi),char(surf)]);
    tmpgii.faces = new_faces.(char(hemi));
    tmpgii.mat = sphere.mat;
    if strcmp(char(surf),'_fsLR_fsaverage_reg')
      %save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.reg']);
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.reg.gii']);
    elseif strcmp(char(surf),'_59k_white')
      %save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.white']);
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.white.gii']);
    end
  end
end


gii = gifti('./output_MNI/surf/rh.sphere.reg.gii');
rhSphereRegCoords = gii.vertices; rhSphereRegFaces = gii.faces;
gii = gifti('./output_MNI/surf/lh.sphere.reg.gii');
lhSphereRegCoords = gii.vertices; lhSphereRegFaces = gii.faces;
gii = gifti('./output_MNI/surf/rh.white.gii');
rhWhiteCoords = gii.vertices; rhWhiteFaces = gii.faces;
gii = gifti('./output_MNI/surf/lh.white.gii');
lhWhiteCoords = gii.vertices; lhWhiteFaces = gii.faces;

save('./saved_giftis.mat','rhSphereRegCoords','rhSphereRegFaces','lhSphereRegCoords','lhSphereRegFaces', ...
'rhWhiteCoords','rhWhiteFaces','lhWhiteCoords','lhWhiteFaces')


end
