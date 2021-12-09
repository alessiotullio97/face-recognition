function [dbPersonPath] = takeNextIndex(dbPath, person)

        cd(dbPath);
        
        files = dir;
        directoryNames = {files([files.isdir]).name};
        directoryNames = directoryNames(~ismember(directoryNames,{'.','..'}));

        str = max(directoryNames);

        disp(str);
        dbPersonPath = "";
end