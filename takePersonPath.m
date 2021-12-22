function [dbPersonPath, personIndex] = takePersonPath(dbPath, person)

        % Locate full path of people DB
        personDB = fullfile(dbPath, 'peopleDB.txt');

        %disp(personDB);
        
        % Perform a lookup on the personDB: verify if the person has been
        % already registered
        fileID = fopen(personDB, 'at+');
        frewind(fileID);

        disp("People db is stored at " + personDB + ". fileID = " + string(fileID));

        matched = false;
        %lineI = 0;
        while ~feof(fileID) && matched == false
                %lineI = lineI + 1;
                tline = fgets(fileID);
                if tline == -1
                        disp("tline is empty");
                        break;
                else
                        % disp("Line" + string(lineI) + " is: " + tline);
                        identityI = split(tline, ', ');
                        folderI = identityI{1};
                        personI = strtrim(identityI{2});
                        
                        % disp(['folederI:{' folderI '}, personI:{' personI '} ']);

                        if strcmp(personI, person) == 1
                                %dbPersonPath = strcat(dbPath, '/', folderI);
                                dbPersonPath = fullfile(dbPath, folderI);
                                %% Modify here tot aek next index
                               
                                matched = true;
                        end
                end
        end
        
        
        % if it's the first time the people identify itself, register it
        if matched == false
                files = dir(dbPath);
                directoryNames = {files([files.isdir]).name};
                directoryNames = directoryNames(~ismember(directoryNames, {'.','..'}));
        
                val = cellfun(@(x) numel(x), directoryNames);
                out = directoryNames(val==max(val));
        
                [firstIndex, lastIndex] = size(out);
                lastString = out{lastIndex};
        
                personIndex = sscanf(lastString, 's%d') + 1;
                    
                newFolder = sprintf('/s%d', personIndex);
                
                dbPersonPath = strcat(dbPath, newFolder);
                mkdir(dbPersonPath);

                % register the person within the DB
                fprintf(fileID, 's%d, %s\n', personIndex, person);
        end

        fclose(fileID);
end