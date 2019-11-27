function transform(filename, dx, dy, dz, flip_x, flip_y, flip_z)
  % translate first, then flips
  %
  % Usage: transform(filename, dx, dy, dz, flip_x, flip_y, flip_z)
  %

  orig = gifti(filename);
  transformed = gifti;
  transformed.faces = orig.faces;
  transformed.mat = orig.mat;
  vertices_len = size(orig.vertices,1);
  %tempmat = transformed.vertices;
  for i = (1:vertices_len)
    transformed.vertices(i,1) = orig.vertices(i,1) + dx;
    transformed.vertices(i,2) = orig.vertices(i,2) + dy;
    transformed.vertices(i,3) = orig.vertices(i,3) + dz;
  end
  tempmat = transformed.vertices;

  if flip_x == true
    for i = (1:vertices_len)
      transformed.vertices(i,1) = -tempmat(i,1);
    end
  end
  if flip_y == true
    for i = (1:vertices_len)
      transformed.vertices(i,2) = -tempmat(i,2);
    end
  end
  if flip_z == true
    for i = (1:vertices_len)
      transformed.vertices(i,3) = -tempmat(i,3);
    end
  end
%  save_gifti(transformed,[filename(1:end-4),'_transformed.gii']);
  save_gifti(transformed,'MNINonLinear_59k_fsLR_lh_white.gii');
end

% 1.0, 17.5, -19.0
