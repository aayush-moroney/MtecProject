function [vertex,range] = GiveVertexFromCompleteGraph(myStruct,type,v,r)
NNodes = myStruct.NNodes;
range = ones(1,sum(NNodes));
low = 1;
if(type ~= 1)
    low = sum(NNodes(1:(type-1)));
end
high = sum(NNodes(1:(type)));
range(low:high) = range(low:high) * r;
if(type == 1)
        vertex = v;
else
    vertex = low + v;
end
end
