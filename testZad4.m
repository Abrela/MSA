clear all;
clc;
close all;

%% Wczytywanie sekwencji z pliku o formacie FASTA

%A = 'sequence.fasta';
X1 = "Rhino.txt";
X2 = "Mastodon.txt";
%D = 'Human.txt';
X3 = "AsiaticElephant.txt";

%fastaContent1=fetchFile(B)
%fastaContent2=fetchFile(C)

%% Wczytywanie sekwencji z bazy danych NCBI

%%fastaContent=fetchFasta('AC073210.8')

%% Zapisa w formie tablicy struktur

%[S]=saveAsStruct( fastaContent )

%% Funkcja do odczytu pliku, parsowania i zapisu w formie struktury

 %x1 = 'ATTGCCATT';
 %x2 = 'ATGGCCATT';
 %x3 = 'ATCCAATTTT';
 %x4 = 'ATCTTCTT';
 %x5 = 'ACTGACC';
 %['x1.txt'; 'x2.txt'; 'x3.txt'; 'x4.txt'; 'x5.txt'];
 x1 = 'x1.txt';
 x2 = 'x2.txt';
 x3 = 'x3.txt';
 x4 = 'x4.txt';
 x5 = 'x5.txt';
 
 %vector = [X1; X2; X3]; 
 vector = [x1; x2; x3; x4; x5];
 X = cellstr(vector);
 disp(X);
 
 %FastaSet1 = loadFasta('file','sequence.fasta');
 %FastaSet2 = loadFasta('file','sequence.fasta');
 FastaSet = loadFasta('file',X); 
 %FastaSet2 = loadFasta('file',D);
 
 %% Dopasowanie wielu sekwencji
 
 match = 1;
 mismatch = -1;
 gap = -2;
 
 [alignmentOut, maxOut, starSeqOut, starHeaderOut] = multipleSequenceAlignment(FastaSet , match, mismatch, gap);
 
 %% Zapis dopasowania wielu sekwencji jako pliki fasta
 
 fastaOutput(alignmentOut, starHeaderOut, starSeqOut);
 
 %% Zapis dopasowania wielu sekwencji w formacie programu CLUSTAL
 
 CLUSTALoutput(alignmentOut, starHeaderOut, starSeqOut, maxOut);