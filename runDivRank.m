function res = runDivRank(strct,alpha,lamda,type,v,r)

    for i=1:size(strct.metaData,1)
            strct.metaData(i,i) = strct.metaData(i,i) + 0.001;
    end
    
    strct = normalize_adj_persnl_mat(strct);
    [vertex,range] = GiveVertexFromCompleteGraph(strct,type,v,r);
    res = QueryBiasedDivRank(strct.normGraph,lamda,alpha,strct.persnl_mat,vertex,range,r,strct.NNodes, strct.metaData);

end
