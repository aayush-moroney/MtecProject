function drawGraph(path,A)
s = size(A,1);
fid = fopen(path,'w');
for i =1:s
for j=1:s
    if(A(i,j) == 1)
        fprintf(fid,'%d\t%d\n',i,j);
    end
end
end
fclose(fid);
end