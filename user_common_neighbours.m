function match = user_common_neighbours(train,test)
us_us = train.Graph{1,1};
us_mv = train.Graph{1,2};
mv_us = train.Graph{2,1};
us_loc = train.Graph{1,4};
mv_ac = train.Graph{2,6};
ac_mv = train.Graph{6,2};
loc_us = train.Graph{4,1};
us_mv_cmn_nbr = us_mv * mv_us * us_mv;
tmp = us_mv_cmn_nbr .*(-us_mv);
us_mv_cmn_nbr(tmp<0)=0;
[score,rank] = sort(us_mv_cmn_nbr,2,'descend');
rank = rank(:,1:10);

tst_usr_mvie = test.Graph{1,2};
active_usr = find(sum(tst_usr_mvie,2)>0);
match = zeros(length(active_usr),1);
for i=1:length(active_usr)
    %rank(active_usr(i),:)
    %score(active_usr(i),1:10)
    %find(tst_usr_mvie(active_usr(i),:))
    %pause()
    match(i) = length(intersect(rank(active_usr(i),:),find(tst_usr_mvie(active_usr(i),:)>0)));
end
end