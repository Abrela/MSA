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
  
amountSeq = length(fastaStruct); %ilosc sekwencji
star = fastaStruct(coordinateRowX(1,1)).sequence; %centrum gwiazdy przypisane do zmiennej
starHeader = fastaStruct(coordinateRowX(1,1)).header; 


 A = cell(amountSeq-1); %cell w której beda zapisywane dopasowania, oprócz star
 B = cell(amountSeq-1);
 alignment = struct('header', {}, 'sequence', {}); %zapisane sekwencje bez star

 %storzenie struktury dla sekwencji bez centrum, dla u³atwienia wykonywania
 %dopasowañ w pêtli for
 fastaStruct(coordinateRowX(1,1)).sequence = [];
 for i = 1:length(fastaStruct)
     if isempty(fastaStruct(i).sequence) == 1
     else
            A{i,1} = fastaStruct(i).sequence;
            B{i,1} = fastaStruct(i).header;
            alignment1 = struct( 'header', B{i,1}, 'sequence', A{i,1});
            alignment = [alignment; alignment1];
     end
 end
 
 
%multiple alignment
for j = 1:length(alignment)
    
      [ mNW, matrixSize, bias, vertical, horizontal ]= ...
      matrixScore(star, alignment(j).sequence, match, mismatch, gap);
      [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = ...
      matchPath(matrixSize, bias, vertical, horizontal, star, alignment(j).sequence, match, mismatch, gap, mNW );
      
      alignment(j).sequence = s2Out;
      star = s1Out; %Nadpisywanie centrum gwiazdy
      
      
     if j > 1 %petla uruchamiana dopiero od drugiej iteracji  
       for m = 1:length(alignment)-1
           seq1Star = star;
           seq2 = alignment(m).sequence;
           
           
          [ mNW, matrixSize, bias, vertical, horizontal ]= ...
          matrixScore(seq1Star, seq2, match, mismatch, gap);
          [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = ...
          matchPath(matrixSize, bias, vertical, horizontal, seq1Star, seq2, match, mismatch, gap, mNW );
  
           alignment(m).sequence = s2Out;

       end
     end   
end

%przepisanie wszystkich sekwencji do wyjœciowej struktury
for i = 1:length(alignment)
    for j = 1:length(fastaStruct)
        
        if isequal(starHeader, fastaStruct(j).header)

            fastaStruct(coordinateRowX(1,1)).sequence = star;

        elseif isequal(fastaStruct(j).header, alignment(i).header)

            fastaStruct(j).sequence = alignment(i).sequence;

        end
    end
end

%znalezienie najd³u¿szej sekwencji, aby wyrównaæ do niej pozosta³e
A = [];
for i = 1:length(scoreRow)
    
a = length(fastaStruct(i).sequence);
A=[A; a];

end

%wyrównanie sekwencji
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

