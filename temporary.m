function match = temporary(trmat,tstmat,hgh_conn_usr,active_usr_set)

r_set = 0.0006;%0.002 0.0002 0.000002];
match = zeros(length(hgh_conn_usr),length(r_set));
tstdeg = zeros(length(hgh_conn_usr),1);
for j = 1:length(r_set)
     temp = [];
parfor i=1:length(hgh_conn_usr)
    
    res = runDivRank(trmat,0.25,0.5,1,active_usr_set(hgh_conn_usr(i)),r_set(j));
    
    g_score = res.score(trmat.NNodes(1)+1:sum(trmat.NNodes(1:2)));
    
    g_score(trmat.Graph{1,2}(active_usr_set(hgh_conn_usr(i)),:) == 1) = -1;
    [score,rank] = sort(g_score,'descend');
    tst_usr_g = find(tstmat.Graph{1,2}(active_usr_set(hgh_conn_usr(i)),:) == 1);
    tstdeg(i) = length(tst_usr_g);
    insct = intersect(tst_usr_g,rank(1:20));
     temp(i) = length(insct);
end
match(:,j) = temp;
j
end
match(:,length(r_set)+1) = tstdeg;
%match = [active_usr_set(hgh_conn_usr)' match];
end