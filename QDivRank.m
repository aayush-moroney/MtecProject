function output = QDivRank(W, lambda_value, alpha_value, r,vertex,range,regularizer_const,NNodes)
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
max_iter = 100;
diff_value = 1e+10;
tol_value = 1e-9;

W0 = alpha_value * W  + spdiags((1-alpha_value)*ones(n,1), 0, n, n);

Pt_old = pr;
while ((num_iter < max_iter) && (diff_value > tol_value))
    sum(Pt_old)
    score = Pt_old * W0;
    sum(score)
    cc = 0;
    %length(NNodes)
    for i=1:length(NNodes)
        score(cc+1:NNodes(i)) = score(cc+1:NNodes(i))/sum(score(cc+1:NNodes(i)));
        cc = cc + NNodes(i);
    end
    sum(score)
    Pt_new = (1-lambda_value) * r + lambda_value * score;  
    sum(Pt_new)
    Pt_new = Pt_new .* range;
    Pt_new(vertex) = Pt_new(vertex) + (1-regularizer_const);
    sum(Pt_new)
    diff_value = norm(Pt_new - Pt_old);
    Pt_old = Pt_new;
    num_iter = num_iter + 1;
end

%% Output
output.num_iter = num_iter;
output.pr = Pt_new;
[output.score, output.rank] = sort(Pt_new, 'descend');