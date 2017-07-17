function [score,rank] = PrecisionRecall(trmat,score,qtype,qnode,rtype)
qTrain = trmat.Graph{qtype,rtype}(qnode,:);
r_score = score(sum(trmat.NNodes(1:rtype-1))+1:sum(trmat.NNodes(1:rtype)));
for i=1:trmat.NNodes(rtype)
    if(qTrain(i) == 1)
        r_score(i) = -1;
    end
end
[score,rank] = sort(r_score,'descend');
end