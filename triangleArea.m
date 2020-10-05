function [Area] = triangleArea(vertices, faces)

Area = [];
  for i = 1:size(faces,1)
    x1 = vertices(faces(i,1),1); y1 = vertices(faces(i,1),2); z1 = vertices(faces(i,1),3);
    x2 = vertices(faces(i,2),1); y2 = vertices(faces(i,2),2); z2 = vertices(faces(i,2),3);
    x3 = vertices(faces(i,3),1); y3 = vertices(faces(i,3),2); z3 = vertices(faces(i,3),3);

    AB = ((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)^.5;
    AC = ((x1-x3)^2 + (y1-y3)^2 + (z1-z3)^2)^.5;
    BC = ((x2-x3)^2 + (y2-y3)^2 + (z2-z3)^2)^.5;

    p = (AB+AC+BC)/2;
    A = sqrt(p*(p-AB)*(p-AC)*(p-BC));
    Area(i) = A;
  end

end
