function [] = CLUSTALoutput(multipleAlignment, starHeader, starSeq, max)

fprintf('%.60s \n\n', 'Format CLUSTAL');

for j = 1:length(multipleAlignment)
   
    if isequal(starHeader, multipleAlignment(j).header)
      % wyœwietlane puste pole, bo w tym przypadku fukncja ma omijac porownanie z "gwiazda"
    else
    line = '';
    for i = 1:max
        if starSeq(i)=='-'
            line = strcat(line, " ");
        elseif starSeq(i)==multipleAlignment(j).sequence(i)
            line = strcat(line, '*');
        else
            line = strcat(line, " ");
        end
    end
    end
    
    if isequal(starHeader, multipleAlignment(j).header)

    else
       fprintf('\n');
       fprintf('%.25s \t %.60s \t %d \n',starHeader, starSeq, max);
       fprintf('%.25s \t %.60s \t %d \n',multipleAlignment(j).header, multipleAlignment(j).sequence, max);
       fprintf('%5.5s \t %.60s \n\n', " ", line);
    end
   
end
fprintf('%.60s \n\n', 'Dopasowanie wielu sekwencji');
fprintf('%.60s \n',starSeq);

for i = 1:length(multipleAlignment)

    if isequal(starHeader, multipleAlignment(i).header)

    else
        fprintf('%.60s \n',multipleAlignment(i).sequence);
    end
    
end

end

