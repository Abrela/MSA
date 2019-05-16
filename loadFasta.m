function [ FastaSetOut ] = loadFasta( method, source )
%LOADFASTA Funkcja g³ówna, która decyduje jak¹ metod¹ bêd¹ wczytywane
%sekwecje.
%   Argumentem wejœciowym jest metoda jak¹ wczytywany jest plik (method) 
%   oraz sekwencja (source). Funkcja zawiera subfunkcje. Argumentem 
%   wyjœciowym jest sparsowany oraz umieszczony w strukturze (struct)  
%   wczytany wczeœñiej plik(source). 
vec = cell(length(source),1);

for i = 1:length(source)
if method == "file"
    fastaContent = fetchFile(source{i,1}); % subfunkcja
elseif method == "ncbi"
    fastaContent = fetchFasta(source{i,1}); % subfunkcja
else
    fprintf('None of the entered inputs are valid');
end
vec{i,1} = fastaContent;  
end

X = cellstr(vec);

[FastaSet] = saveAsStruct(X); % subfunkcja
FastaSetOut = FastaSet;

end