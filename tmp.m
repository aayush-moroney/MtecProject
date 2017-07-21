for i=1:5
for j=1:5
grp = mat.Graph{i,j};
grp(grp>0) = 1;
mat.Graph{i,j} = grp;
end
end