function createSurfs(surfaces, HCP)

lh_white = gifti(strcat(surfaces,'/lh.white.gii'));
rh_white = gifti(strcat(surfaces,'/rh.white.gii'));
lh_pial = gifti(strcat(surfaces,'/lh.pial.gii'));
rh_pial = gifti(strcat(surfaces,'/rh.pial.gii'));
lh_inflated = gifti(strcat(surfaces,'/lh.inflated.gii'));
rh_inflated = gifti(strcat(surfaces,'/rh.inflated.gii'));

if HCP
  if size(lh_white.vertices,1) == 32492
    lh_fsLR_fsaverage_reg = gifti('resample_fsaverage/fs_LR-deformed_to-fsaverage.L.sphere.32k_fs_LR.surf.gii');
    rh_fsLR_fsaverage_reg = gifti('resample_fsaverage/fs_LR-deformed_to-fsaverage.R.sphere.32k_fs_LR.surf.gii');

    lh_atlas = gifti('atlasroi/102816.L.atlasroi.32k_fs_LR.shape.gii');
    rh_atlas = gifti('atlasroi/102816.R.atlasroi.32k_fs_LR.shape.gii');
  elseif size(lh_white.vertices,1) == 59292
    lh_fsLR_fsaverage_reg = gifti('resample_fsaverage/fs_LR-deformed_to-fsaverage.L.sphere.59k_fs_LR.surf.gii');
    rh_fsLR_fsaverage_reg = gifti('resample_fsaverage/fs_LR-deformed_to-fsaverage.R.sphere.59k_fs_LR.surf.gii');

    lh_atlas = gifti('atlasroi/102816.L.atlasroi.59k_fs_LR.shape.gii');
    rh_atlas = gifti('atlasroi/102816.R.atlasroi.59k_fs_LR.shape.gii');
  else
    error('Surface data does not appear to be from HCP 32k (2mm) or 59k (1.6mm) datasets');
  end

  good_vertices_index = struct;
  good_faces_bool = struct; % not actually used
  new_vertices = struct;
  new_faces = struct;

  for hemi = {'lh' 'rh'}
    atlas = eval([char(hemi),'_atlas']);
    good_vertices_index.(char(hemi)) = [];
    for i=(1:size(atlas.cdata,1))
      if atlas.cdata(i,1) == 1
        idx = int2str(i);
        good_vertices_index.(char(hemi)) = [good_vertices_index.(char(hemi)), i];
      end
    end
    for surf = {'_fsLR_fsaverage_reg' '_white' '_inflated' '_pial'}
      new_vertices.([char(hemi),char(surf)]) = [];
      surfMesh = eval([char(hemi),char(surf)]);
      for i=(1:size(good_vertices_index.(char(hemi)),2))
        new_vertices.([char(hemi),char(surf)]) = [new_vertices.([char(hemi),char(surf)]); eval(['surfMesh.vertices(',int2str(good_vertices_index.(char(hemi))(i)),',:)'])];
      end
    end
  end
  for hemi = {'lh' 'rh'}
    surfMesh = eval([char(hemi),'_white']);
      new_faces.(char(hemi)) = [];
      good_faces_bool.(char(hemi)) = [];
      for i=(1:size(surfMesh.faces,1))
        if ismember(surfMesh.faces(i,1),good_vertices_index.(char(hemi))) && ismember(surfMesh.faces(i,2),good_vertices_index.(char(hemi))) && ismember(surfMesh.faces(i,3),good_vertices_index.(char(hemi)))
          good_faces_bool.(char(hemi)) = [good_faces_bool.(char(hemi)), 1];
          idx = int2str(i);
          new_faces.(char(hemi)) = [new_faces.(char(hemi)); eval(['surfMesh.faces(',idx,',:)'])];
        else
          good_faces_bool.(char(hemi)) = [good_faces_bool.(char(hemi)), 0];
        end
      end
      for i = (1:size(surfMesh.vertices,1))
        if ismember(i, good_vertices_index.(char(hemi)))
          new_faces.(char(hemi))(new_faces.(char(hemi)) == i) = find(good_vertices_index.(char(hemi)) == i);
        end
      end
    for surf = {'_fsLR_fsaverage_reg' '_white' '_inflated' '_pial' '_sphere'}
      tmpgii = gifti;
      tmpgii.vertices = single(new_vertices.([char(hemi),char(surf)]));
      tmpgii.faces = int32(new_faces.(char(hemi)));
      tmpgii.mat = surfMesh.mat;
      if strcmp(char(surf),'_fsLR_fsaverage_reg')
        save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.reg.gii']);
      elseif strcmp(char(surf),'_white')
        save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.white.gii']);
      elseif strcmp(char(surf),'_inflated')
        save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.inflated.gii']);
      elseif strcmp(char(surf),'_pial')
        save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.pial.gii']);
      elseif strcmp(char(surf),'_sphere')
        save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.gii']);
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



elseif ~HCP
  ;
end

end

  for surf = {'_fsLR_fsaverage_reg' '_32k_white' '_32k_inflated' '_32k_pial' '_32k_sphere'}
%for surf = {'_fsLR_fsaverage_reg' '_59k_white'}
    tmpgii = gifti;
    tmpgii.vertices = single(new_vertices.([char(hemi),char(surf)]));
    tmpgii.faces = int32(new_faces.(char(hemi)));
    tmpgii.mat = surfMesh.mat;
    if strcmp(char(surf),'_fsLR_fsaverage_reg')
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.reg.gii']);
    elseif strcmp(char(surf),'_32k_white')
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.white.gii']);
    elseif strcmp(char(surf),'_32k_inflated')
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.inflated.gii']);
    elseif strcmp(char(surf),'_32k_pial')
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.pial.gii']);
    elseif strcmp(char(surf),'_32k_sphere')
      save_gifti(tmpgii,['./output_MNI/surf/',char(hemi),'.sphere.gii']);
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
