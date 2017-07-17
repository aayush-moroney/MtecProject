user1 = 0;
user2 = 0;
match = 398;
for i=1:length(active_users)
    us1 = user_group(active_users(i),:);
    for j=i+1:length(active_users)
        us2 = user_group(active_users(j),:);
        tmp = sum(us1&us2);
        if(tmp<match)
            match = tmp;
            user1 = i;
            user2 = j;
        end
    end
end
