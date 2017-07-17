function [score,rank] = find_rank_score_for_diff_rval(trmat,qtype,qnode,rtype,r_val)
score = zeros(length(r_val),10);
rank = zeros(length(r_val),10);
for i=1:length(r_val)
    res = runDivRank(trmat,0.25,0.5,qtype,qnode,r_val(i));
    [tmp_score,tmp_rank] = PrecisionRecall(trmat,res.score,qtype,qnode,rtype);
    score(i,:) = tmp_score(1:10);
    rank(i,:) = tmp_rank(1:10);
end
end