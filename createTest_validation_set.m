function [train,test,validation] = createTest_validation_set(mat,qNType,rNType)
train = mat;
test = mat;
validation = mat;
test.Graph{qNType,rNType} = sparse(size(mat.Graph{qNType,rNType},1),size(mat.Graph{qNType,rNType},2));
validation.Graph{qNType,rNType} = sparse(size(mat.Graph{qNType,rNType},1),size(mat.Graph{qNType,rNType},2));

NoEdges = sum(mat.Graph{qNType,rNType},2);
TwntypercEdges = floor(0.2 * NoEdges);

for i=1:length(NoEdges)
    if(NoEdges(i) > 0 && TwntypercEdges(i)>0)
        randEdges = randperm(NoEdges(i),TwntypercEdges(i));
        Edges = find(mat.Graph{qNType,rNType}(i,:)>0);
        test.Graph{qNType,rNType}(i,Edges(randEdges)) = 1;
        train.Graph{qNType,rNType}(i,Edges(randEdges)) = 0;
    end
end


% NoEdges = zeros(size(train.Graph{qNType,rNType},1),1);
% TwntypercEdges = zeros(size(train.Graph{qNType,rNType},1),1);
% for i=1:size(train.Graph{qNType,rNType},1)
%     NoEdges(i) = sum(train.Graph{qNType,rNType}(i,:)>0);
%     TwntypercEdges(i) = floor(0.2 * NoEdges(i));
% end
% for i=1:length(NoEdges)
%     if(NoEdges(i) > 0 && TwntypercEdges(i)>0)
%         randEdges = randperm(NoEdges(i),TwntypercEdges(i));
%         Edges = find(train.Graph{qNType,rNType}(i,:)>0);
%         validation.Graph{qNType,rNType}(i,Edges(randEdges)) = 1;
%         train.Graph{qNType,rNType}(i,Edges(randEdges)) = 0;
%     end
% end

end