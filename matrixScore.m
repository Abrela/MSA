function [ mNW, matrixSize, bias, vertical, horizontal ] = matrixScore( seq1, seq2, match, mismatch, gap )

if(isempty(seq1)||isempty(seq2))
    msgbox('D³ugoœci sekwencji musz¹ byæ wiêksze od zera!','B³¹d','error');
else
    N1 = length(seq1);
    N2 = length(seq2);

    mNW = zeros( N1+1, N2+1 );
    [matrixSize]=size(mNW);

    mNW(1,1) = 0; % elemnt (1,1) macierzy zawsze 0
    for i = 2:(N1+1) 
        mNW(i,1) = mNW(i-1,1)+gap; % wype³nienie pierwszej kolumny punktacj¹ gap
    end
    for j = 2:(N2+1)  
        mNW(1,j) = mNW(1,j-1)+gap; % wype³nienie pierwszego wiersza punktacj¹ gap
    end

    %mo¿liwe przejœcia we wszystkich kierunkach
    bias = zeros(size(mNW,1), size(mNW,2));
    vertical = zeros(size(mNW,1), size(mNW,2));
    vertical(2:size(vertical,1),1) = ones(size(vertical,1)-1,1); % wype³nienie jedynkami pierwszej kolumny vertical
    horizontal = zeros(size(mNW,1), size(mNW,2));
    horizontal(1,2:size(horizontal,2)) = ones(1,size(horizontal,2)-1); % wype³nienie jedynkami pierwszego wiersza horizontal 

    currentRow = mNW(1,:);

    for outer = 2:matrixSize(1) %kolejne nr wierszy

        lastRow = currentRow; %zapisany poprzedni wiersz
        currentRow = mNW(outer,:); %zapisany aktualny wiersz
        best=currentRow(1); %pierwszy element z atualnego wiersza nadpisany jako najlepsza opcja 

        for inner = 2:matrixSize(2) %kolejne nr kolumn

        up = lastRow(inner) + gap;
        left = best + gap;
        if seq1(outer-1) == seq2(inner-1) %nie chcemy iterowaæ sekwencji od 2 pozycji, dlatego odejmujemy 1, zeby 
                diagonal = lastRow(inner - 1) + match;
            else
                diagonal = lastRow(inner - 1) + mismatch;
        end

         MAX = max([diagonal, up, left]);

        if(MAX == diagonal)
                bias(outer, inner) = 1;
        end
        if(MAX == up)
                vertical(outer, inner) = 1;
        end
        if(MAX == left)
                horizontal(outer, inner) = 1;
        end

        if up > left
            best = up;     
        else 
            best = left;     
        end

        if diagonal >= best
            best = diagonal;
        end
        currentRow(inner) = best; % najlepszy wynik punktacji zapisywany zapisywany w macierzy

        end %end inner

        mNW(outer,:) = currentRow; % zapisz wiersz z punktacja w macierzy

    end %end outer
end
end

