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
seq = fastaStruct(coordinateRowX).sequence; %centrum gwiazdy przypisane do zmiennej 

 alignment = cell(amountSeq-1); %cell w której beda zapisywane dopasowania, oprócz star
 star = ''; %zmienna do zapisu centrum gwiazdy

%multiple alignment
for j = 1:(amountSeq)
    
    if isequal(seq, fastaStruct(j).sequence)

    else
      [ mNW, matrixSize, bias, vertical, horizontal ]= ...
      matrixScore(seq, fastaStruct(j).sequence, match, mismatch, gap);
      [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = ...
      matchPath(matrixSize, bias, vertical, horizontal, seq, fastaStruct(j).sequence, match, mismatch, gap, mNW );
      alignment{j,1} = s2Out;
      star = s1Out;

      if j > 2 %petla uruchamiana dopiero od trzeciej iteracji
        m = length(alignment);
        disp("M: " + m);
      if m > 1 
          seq1 = star;
          disp("Seq1: " + seq1);
          seq2 = alignment{m-1,1};
          disp("Seq2: " + seq2);
          seqTemp = '';
          
           if length(seq1) > length(seq2) %jeœli seq2 krótsze od centrum gwiazdy to wyrównujemy d³ugoœæ obu 
                 while length(seq1) ~= length(seq2)
                     if length(seq1) > length(seq2)
                     seq2 = strcat(seq2, '-');
                     end
                 end
           end
           
          for k = 1:length(seq1)
              disp("K: " + k);
                 if(seq1(k) == '-')
                    seqTemp = insertBefore(seq2,seq2(k),'-');
                    disp("SeqTemp: " + seqTemp);
                 end
          end
          alignment{m-1,1} = seqTemp;
          disp("Alignment{}: " + alignment{m-1,1});
          m = m-1;
      end
      end       
    end

end

for i = 1:length(alignment)
    
    fastaStruct(i).sequence = alignment{i,1};
    
end

fastaStruct(coordinateRowX(1,1)).sequence = star;

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

