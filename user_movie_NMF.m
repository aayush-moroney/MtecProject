function match = user_movie_NMF(train,test)
us_us = train.Graph{1,1};
us_mv = train.Graph{1,2};
[W,H] = nnmf(us_mv,10);
us_mv_nmf = W*H;
us_mv_nmf = us_mv_nmf .*(-us_mv);
[score,rank] = sort(us_mv_nmf,2,'descend');
rank = rank(:,1:10);

tst_usr_mvie = test.Graph{1,2};
active_usr = find(sum(tst_usr_mvie,2)>0);
match = zeros(length(active_usr),1);
for i=1:length(active_usr)
    match(i) = length(intersect(rank(active_usr(i),:),find(tst_usr_mvie(active_usr(i),:)>0)));
end
end