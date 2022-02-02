function [I] = getFaceFromDB(personLabel)
        file = fullfile(pwd, 'database', personLabel, '1.pgm');
        % Recognized Face
        I = imread(file);
end