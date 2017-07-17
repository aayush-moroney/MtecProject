function strct = normalize_adj_persnl_mat(strct)

NNodes = strct.NNodes;
ss = length(NNodes);
cc = 0;
for i=1:ss
    persnl_mat(cc+1:cc+NNodes(i)) = 1/NNodes(i);
    cc = cc + NNodes(i);
end
strct.persnl_mat = persnl_mat;

[src dest] = find(strct.metaData);
strct.normGraph = cell(ss,ss);
for i=1:length(src)
    Degree = sum(strct.metaData(src(i),:));
    A = sparse(strct.Graph{src(i),dest(i)});
    rSum = sum(A, 2);
    iDeg = 1./rSum;
    iDeg(rSum==0) = 0;
    %A = A';
    %A(:,rSum==0)=1;
    %A = A';
    strct.normGraph{src(i),dest(i)} = (spdiags(iDeg, 0, size(A, 1), size(A, 1)) / Degree) * A;
end

[src dest] = find(~strct.metaData);
for i=1:length(src)
    strct.normGraph{src(i),dest(i)} = sparse(NNodes(src(i)), NNodes(dest(i)));
end

strct.normGraph = sparse(cell2mat(strct.normGraph));

end