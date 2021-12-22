function s = getRelativeName(index)
        app.PersonListDropDown.Visible = true;
        app.PersonListDropDown.Items = {};

        personDB = fullfile(pwd, 'database', 'peopleDB.txt');
        fileID = fopen(personDB, 'r');
        while ~feof(fileID)
                tline = fgets(fileID);
                if tline == -1
                        break;
                else 
                        tline = split(tline, ', ');
                        if index == sscanf(tline{1}, 's%d')
                                s = tline{2};
                                return;
                        end
                end
        end
        s = 'Not Matched';        
end