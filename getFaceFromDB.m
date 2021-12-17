function [recognized] = getFaceFromDB(personLabel)
        file = fullfile(pwd, 'database', personLabel, '1.pgm');
        recognized = imread(file);
end