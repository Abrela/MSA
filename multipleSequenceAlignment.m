function [alignmentOut, maxOut, starSeqOut, starHeaderOut] = multipleSequenceAlignment(fastaStruct, match, mismatch, gap)

dimension = length(fastaStruct);
MSAscore = zeros(dimension);

for i = 1:dimension
    for j = 1:dimension
        if i==j
            MSAscore(i,j) = 0;
        else
            [ mNW, matrixSize, bias, vertical, horizontal ]= ...
            matrixScore(fastaStruct(i).sequence, fastaStruct(j).sequence, match, mismatch, gap);
            [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = matchPath(matrixSize, bias, vertical, ...
            horizontal, fastaStruct(i).sequence, fastaStruct(j).sequence, match, mismatch, gap, mNW );

            MSAscore(i,j) = scoreOut;
        end
    end
end

scoreRow = [];
for i = 1:dimension
    row = MSAscore(i, :);
    scoreRow1 = sum(row);
    scoreRow = [scoreRow; scoreRow1];
end

maxScoreRow = max(scoreRow);
[coordinateRowX, coordinateRowY] = find(maxScoreRow == scoreRow);
  
seq = fastaStruct(coordinateRowX).sequence;

%global alignment
for j = 1:length(scoreRow)
    
    if isequal(seq, fastaStruct(j).sequence)
      seq = fastaStruct(j).sequence;
    else
      [ mNW, matrixSize, bias, vertical, horizontal ]= ...
      matrixScore(seq, fastaStruct(j).sequence, match, mismatch, gap);
      [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = ...
      matchPath(matrixSize, bias, vertical, horizontal, seq, fastaStruct(j).sequence, match, mismatch, gap, mNW );
      fastaStruct(j).sequence = s2Out;
    end   

end 

A = [];
for i = 1:length(scoreRow)
    
a = length(fastaStruct(i).sequence);
A=[A; a];

end

%multiple alignment
for i = 1:(length(scoreRow))
 
    while length(fastaStruct(i).sequence) ~= max(A)
        
        if length(fastaStruct(i).sequence) < max(A)

        fastaStruct(i).sequence = strcat(fastaStruct(i).sequence, '-');

        end
    end
end

alignmentOut = fastaStruct;
maxOut = max(A); 
starSeqOut = fastaStruct(coordinateRowX).sequence;
starHeaderOut = fastaStruct(coordinateRowX).header; 

end

