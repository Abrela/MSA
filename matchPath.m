function [pathOut, identityOut, gapsOut, s1Out, s2Out, lengthAlignmentOut, scoreOut] = ...
    matchPath(matrixSize, bias, vertical, horizontal, seq1, seq2, match, mismatch, gap, mNW )

    last = matrixSize; % parametr last przechowuje wektor wymiaru macierzy punktacji
    path = zeros(matrixSize);
    s1='';
    s2='';
    gaps = 0;
    score = 0;
    identity = 0;
    %path(last(1),last(2)) = 1;

    while (last(1)~=1 || last(2)~=1) % last(1) - ilosc wierszy, last(2) - ilosc kolumn
        
                path(last(1),last(2)) = 1;             
                diagonal = bias(last(1),last(2));
                left = vertical(last(1),last(2));
                up = horizontal(last(1),last(2));
                 
                if(diagonal == 1)
                    max1 = mNW(last(1)-1,last(2)-1);
                else
                    max1 = NaN;
                end
                if(left == 1)
                    max2 = mNW(last(1)-1,last(2));
                else
                    max2 = NaN;
                end
                if(up == 1)
                    max3 = mNW(last(1),last(2)-1);
                else
                    max3 = NaN; 
                end
                
                MAX = max([max1, max2, max3]);

                if(MAX == max1 )
                    last = [last(1)-1, last(2)-1];
                    s1 = strcat(s1, seq1(last(1)));
                    s2 = strcat(s2, seq2(last(2)));
                    if (seq1(last(1)) == seq2(last(2)))
                        score = score + match;
                        identity = identity+1;
                    else
                       score = score + mismatch;
                    end 
                end
                if(MAX == max2)
                    last = [last(1)-1, last(2)]; 

                        gaps = gaps+1;
                        score = score + gap;
                        s1 = strcat(s1, seq1(last(1)));
                        s2 = strcat(s2, '-');
                end
                if(MAX == max3)
                        last = [last(1), last(2)-1];
                        
                        gaps = gaps+1;
                        score = score + gap;
                        s1 = strcat(s1, '-');
                        s2 = strcat(s2, seq2(last(2)));
                end

     
                
    end
        pathOut = path;
        identityOut = identity;
        gapsOut = gaps;
        s1Out = fliplr(s1);
        s2Out = fliplr(s2);
        scoreOut = score;
                
        
         % d³ugoœæ lokalnego dopasowania
        [r, c] = size(path);
        lengthAlignment = 0;
        for m = 1:r
            for n = 1:c
                if (path(m,n) == 1)
                    lengthAlignment = lengthAlignment+1;
                end
            end
        end
        lengthAlignmentOut = lengthAlignment; 

end

