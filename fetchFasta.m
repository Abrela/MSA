function fastaContent = fetchFasta( identifier )
%FETCHFASTA Wczytywanie sekwencji z bazy danych NCBI.

URL = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi';
fastaContent = urlread(URL, 'get',{'db','nucleotide', 'rettype','fasta',...
    'id',identifier});

end

