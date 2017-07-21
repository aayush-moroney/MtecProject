function mat = createAdjMat(struct)
%struct = load(path);
%struct = struct.meetUpTrain;
count = struct.entityCnt;
metaData = zeros(count);
for i=1:struct.relationCnt
    metaData(struct.relationIdx(i,1),struct.relationIdx(i,2)) = 1;
end
metaData = metaData + metaData';
completeG = cell(count,count);
NNodes = zeros(struct.entityCnt,1);
for i=1:struct.relationCnt
    completeG{struct.relationIdx(i,1),struct.relationIdx(i,2)} = struct.relation{i};
    completeG{struct.relationIdx(i,2),struct.relationIdx(i,1)} = struct.relation{i}';
    NNodes(i) = length(struct.entity{i});
end
for i=1:count
for j=1:count
if(isempty(completeG{i,j}))
%completeG{i,j} = sparse(struct.NNodes(i),struct.NNodes(j));
completeG{i,j} = sparse(NNodes(i),NNodes(j));
end
end
end
metaData(metaData>1) = 1;
mat.Graph = completeG;
mat.metaData = metaData;
%mat.NNodes = struct.NNodes;
mat.NNodes = NNodes;
end