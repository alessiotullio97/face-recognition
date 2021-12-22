function updatePersonListBox(app)
   
        app.PersonListDropDown.Visible = true;
        app.PersonListDropDown.Items = {};

        personDB = fullfile(pwd, 'database', 'peopleDB.txt');
        fileID = fopen(personDB, 'r');
        while ~feof(fileID)
                tline = fgets(fileID);
                if tline == -1
                        break;
                else
                        app.PersonListDropDown.Items = [app.PersonListDropDown.Items tline];
                end
        end
end