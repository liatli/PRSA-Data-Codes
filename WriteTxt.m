function WriteTxt(FileName, Data)
fid=fopen(FileName,'wt');%写入文件路径
[m,n]=size(Data);
 for i=1:1:m
    for j=1:1:n
       if j==n
         fprintf(fid,'%g\n',Data(i,j));
      else
        fprintf(fid,'%g\t',Data(i,j));
       end
    end
end
fclose(fid);