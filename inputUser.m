clear all;
clc;
close all;

prompt = 'Wybierz rodzaj wczytywania plik�w - wpisz file lub ncbi: ';
prompt1 = 'Liczba sekwencji: ';

source = input(prompt, 's');
amount = input(prompt1);

%Testowe pliki z sekwencjami
% x1.txt x2.txt x3.txt x4.txt x5.txt
% AsiaticElephant.txt Rhino.txt Mastodon.txt AfricanaElephant.txt

vector = [];
for i = 1:amount
  prompt2 = 'Wpisz nazw� pliku lub identyfikator: '; 
  vec = input(prompt2, 's');
  vec = string(vec);
  vector = [vector; vec];
end

X = cellstr(vector);
FastaSet = loadFasta(source, X);

prompt3 = 'Podaj punktacj� za dopasowanie: ';
prompt4 = 'Podaj punktacj� za niedopasowanie: ';
prompt5 = 'Podaj punktacj� za przerw�: ';

match = input(prompt3);
mismatch = input(prompt4);
gap = input(prompt5);

[alignmentOut, maxOut, starSeqOut, starHeaderOut] = multipleSequenceAlignment(FastaSet , match, mismatch, gap);

fastaOutput(alignmentOut, starHeaderOut, starSeqOut);

CLUSTALoutput(alignmentOut, starHeaderOut, starSeqOut, maxOut);