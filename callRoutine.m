function callRoutine(app)
        switch app.operation
                case 'registration'
                        app.OutputLabel.FontColor = 'black';
                        num = 10;
                        answer = app.InputEditField.Value;
                        if strcmp(answer, '') == 1
                                app.OutputLabel.FontColor = 'red';
                                app.OutputLabel.Text = 'Please, insert a valid name!';
                                return;
                        else
                                app.OutputLabel.Text = sprintf('%s\n%s',"Welcome " + answer+ ...
                                        "!","Now I will take "+ string(num)+ " snapshots.");
        
                                defaultDB = 'database';
                                currentDir = pwd();
                                dbPath = fullfile(currentDir, defaultDB);
                                res = registerClient(app, dbPath);
                        end
                case 'verification'
                        app.OutputLabel.FontColor = 'black';
                        s = split(app.PersonListDropDown.Value, ', ');
                        idFolder = sscanf(s{1}, 's%d');
                        declaredIdetity = s{2};
                        res = verifyClient(app, idFolder, declaredIdetity);
                case 'identification'
                        app.OutputLabel.FontColor = 'black';
                        app.UIFigure.Pointer = 'watch';
                        s = split(app.PersonListDropDown.Value, ', ');
                        personId = sscanf(s{1}, 's%d');
                        personName = s{2};
                        res = identifyClient(app, personId, personName);
                otherwise
                        warning('Invalid callRoutine');
        end
end