function [ Sout ] = saveAsStruct( ftext )
%SAVEASSTRUCT Subfunkcja, która parsuje wczytany plik FASTA i zapisuje go 
%w strukturze (struct).
%   Argumentem wejœciowym jest wczytywany plik FASTA. Sparsowany plik
%   zapisany w strukturze (osobno nag³ówek i osobno sekwencja) jest
%   argumentem wyjœciowym subfunkcji.

S = struct([]); 

for j = 1:length(ftext)
    
    file = strtrim(strread(ftext{j,1},'%s','whitespace','','delimiter','\n'));
    field=file(1);
    values=file(2:end);

    % Zapis sparsowanego pliku w komórce (cell) 
    C{1,1}=join(values, '');
    C{2,1}=field;

    % Zapis w strukturze (struct)
    S1=struct('header', C{2,1}, 'sequence', C{1,1});
    S = [S, S1];
    
end
    
Sout = S;
end