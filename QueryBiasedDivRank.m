function output = QueryBiasedDivRank(W, lambda_value, alpha_value, r,vertex,range,regularizer_const,NNodes,metaData)
%% Input arguments:
%%%%    -- W: the adjacency matrix of the graph
%%%%    -- lambda_value: paramteter lambda
%%%%    -- alpha_value: paramter alpha
%%%%    -- r: the personalized score. By default, r = ones(1, n)/n;
%% Output arguments:
%%%%    -- output: matlab object variable:
%%%%    -- output.num_iter: number of iterations before convergence
%%%%    -- output.pr: the score ranked by DivRank. Notice that
%%%%    sum(output.pr)==1
%%%%    -- output.rank: intergers, the position ranked by DivRank. 

n = size(W, 2);

pr = r;
num_iter = 0;
max_iter = 50;
diff_value = 1;
tol_value = 1e-9;

metaDeg = sum(metaData,2);

zero_row_sum = sparse(sum(NNodes),length(NNodes));
cum1 = 0;
    for i=1:length(NNodes)
        cum2 = 0;
        for j=1:length(NNodes)
            subMat = W(cum1+1:cum1+NNodes(i), cum2+1:cum2+NNodes(j));
            rowSum = sum(subMat,2);
            temp = sparse(NNodes(i),1);
            if(metaData(i,j)>=1)
                temp(rowSum==0) = 1/metaDeg(i);
                zero_row_sum(cum1+1:cum1+NNodes(i),j)=temp;
            end
            cum2 = cum2 + NNodes(j);
        end
        cum1 = cum1 + NNodes(i);
    end


W0 = alpha_value * W  + spdiags((1-alpha_value)*ones(n,1), 0, n, n);
Pt_old = pr;

while ((num_iter < max_iter) && (diff_value > tol_value))
   % [num_iter diff_value sum(Pt_old)]
    Pt_new = Pt_old .* range;
    Pt_new(vertex) = Pt_new(vertex) + (1-regularizer_const);
    Pt_new = sqrt(Pt_new);
    cum1 = 0;
    for i=1:length(NNodes)
        Pt_new(cum1+1:cum1+NNodes(i)) = Pt_new(cum1+1:cum1+NNodes(i))/sum(Pt_new(cum1+1:cum1+NNodes(i)));
        cum1 = cum1 + NNodes(i);
    end
    
    
    trans = W0 * spdiags(Pt_new',0,n,n);
    cum1 = 0;
    normTrans = cell(length(NNodes),length(NNodes));
    for i=1:length(NNodes)
        cum2 = 0;
        for j=1:length(NNodes)
            subMat = trans(cum1+1:cum1+NNodes(i), cum2+1:cum2+NNodes(j));
            rowSum = sum(subMat,2);
            iRowSum = 1./rowSum;
            iRowSum(rowSum==0) = 0;
            normSubMat = spdiags(iRowSum, 0, NNodes(i), NNodes(i)) * subMat;
            normTrans{i,j} =  normSubMat*metaData(i,j)/sum(metaData(i,:));
            cum2 = cum2 + NNodes(j);
        end
        cum1 = cum1 + NNodes(i);
    end
    trans = sparse(cell2mat(normTrans));
    Pt_new = (1-lambda_value) * r + lambda_value * Pt_new * trans;  
    temp = 0;
    avg_nodes = zeros(1,length(NNodes));
    for i=1:length(NNodes)
        avg_nodes(i) = sum(Pt_new(temp+1:temp+NNodes(i)))/NNodes(i);
        temp = temp + NNodes(i);
    end
    temp = zero_row_sum*spdiags(avg_nodes',0,length(NNodes),length(NNodes));
    Pt_new = Pt_new + (sum(temp,2)'.* Pt_old);
    diff_value = norm(Pt_new - Pt_old);
    
    %Pt_new = length(NNodes)*(Pt_new/sum(Pt_new));
    
    Pt_old = Pt_new;
    num_iter = num_iter + 1;
end

%% Output
output.num_iter = num_iter;
output.pr = Pt_new;
output.score = Pt_new;
[a, output.rank] = sort(Pt_new, 'descend');

end
