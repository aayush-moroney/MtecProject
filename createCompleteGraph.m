function completeG = createCompleteGraph(myStruct)
completeG = cell(5,5);
completeG{myStruct.GROUPS,myStruct.TAG} = myStruct.adj_group_tag;
completeG{myStruct.TAG,myStruct.GROUPS} = myStruct.tag_group;
completeG{myStruct.GROUPS,myStruct.USER} = myStruct.adj_group_users;
completeG{myStruct.USER,myStruct.GROUPS} = myStruct.adj_user_group;
completeG{myStruct.GROUPS,myStruct.EVENTS} = myStruct.adj_group_event;
completeG{myStruct.EVENTS,myStruct.GROUPS} = myStruct.adj_event_group;


completeG{myStruct.USER,myStruct.EVENTS} = myStruct.adj_users_event;
completeG{myStruct.EVENTS,myStruct.USER} = myStruct.adj_event_users;
completeG{myStruct.USER,myStruct.TAG} = myStruct.adj_user_tag;
completeG{myStruct.TAG,myStruct.USER} = myStruct.adj_tag_user;

completeG{myStruct.EVENTS,myStruct.VENUES} = myStruct.adj_event_venue;
completeG{myStruct.VENUES,myStruct.EVENTS} = myStruct.adj_venue_event;


for i=1:5
for j=1:5
if(isempty(completeG{i,j}))
completeG{i,j} = sparse(myStruct.NNodes(i),myStruct.NNodes(j));
end
end
end

completeG = sparse(cell2mat(completeG));
end