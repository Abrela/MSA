function [] = CLUSTALoutput(multipleAlignment, starHeader, starSeq, max)

for j = 1:length(multipleAlignment)
   
    if isequal(starSeq, multipleAlignment(j).sequence)
        disp(''); % wyœwietlane puste pole, bo w tym przypadku fukncja ma omijac porownanie z "gwiazda"
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
     
    if isequal(starSeq, multipleAlignment(j).sequence)
        disp(''); % wyœwietlane puste pole, bo w tym przypadku fukncja ma omijac porownanie z "gwiazda"
    else
       fprintf('\n');
       fprintf('%.25s \t %.60s \t %d \n',starHeader, starSeq, max);
       fprintf('%.25s \t %.60s \t %d \n',multipleAlignment(j).header, multipleAlignment(j).sequence, max);
       fprintf('%25.25s \t %.60s \n\n', " ", line);
    end
   
end

end

