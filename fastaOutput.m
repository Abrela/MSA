function [ ] = fastaOutput(multipleAlignment, starHeader, starSeq)

numSeq = 1;
for i = 1:length(multipleAlignment)
  
if isequal(starSeq, multipleAlignment(i).sequence)
    numSeq = numSeq - 1;
else
    fileName = ['Alignment_' num2str(numSeq), '_.txt'];
    fileID1 = fopen(fileName,'w+');
    fprintf(fileID1, '>%s \n%s \n\n>%s \n%s \n \n', ...
        starHeader, starSeq, multipleAlignment(i).header, multipleAlignment(i).sequence);
    fclose(fileID1);
end

numSeq = numSeq + 1;
end

end

