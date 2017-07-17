function makeDivScore(name,res)
scoring(res.rank) = res.score;
fid = fopen(name,'w');
fprintf(fid,'Id\tDivRank\n');
for i =1:length(scoring)
    fprintf(fid,'%d\t%f\n',i,scoring(i));
end
fclose(fid);
end