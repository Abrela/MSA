function [ FastaSetOut ] = loadFasta( method, source )
%LOADFASTA Funkcja g��wna, kt�ra decyduje jak� metod� b�d� wczytywane
%sekwecje.
%   Argumentem wej�ciowym jest metoda jak� wczytywany jest plik (method) 
%   oraz sekwencja (source). Funkcja zawiera subfunkcje. Argumentem 
%   wyj�ciowym jest sparsowany oraz umieszczony w strukturze (struct)  
%   wczytany wcze��iej plik(source). 
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