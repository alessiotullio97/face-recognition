
function [dbPersonPath] = takePersonPath(dbPath, person)

        personDB = strcat(dbPath, '/peopleDB.txt');
        
        %disp(personDB);
        
        % Perform a lookup on the personDB: verify if the person has been
        % already registered

        fileID = fopen(personDB, 'r+');
        
        % fileID = fopen(personDB);
        
        disp("People db is stored at " + personDB +". fileID = " + string(fileID));

        matched = false;
        while ~feof(fileID) && matched == false
                tline = fgets(fileID);
                if tline == -1
                        disp("tline is empty");
                        break;
                else
                        identityI = split(tline, ', ');
                        folderI = identityI{1};
                        personI = identityI{2};

                        if strcmp(personI, person) == 1
                                dbPersonPath = strcat(dbPath, '/', folderI);
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
        
                nextIndex = sscanf(lastString, 's%d') + 1;
                    
                newFolder = sprintf('/s%d', nextIndex);
                
                dbPersonPath = strcat(dbPath, newFolder);
                mkdir(dbPersonPath);

                % register the person within the DB
                fprintf(fileID, 's%d, %s\n', nextIndex, person);
                %drawnow('update');
        end
end