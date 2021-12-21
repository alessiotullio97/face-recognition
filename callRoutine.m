function callRoutine(app)
        switch app.operation
                case 'registration'
                        num = 10;
                        answer = app.InputEditField.Value;
                        if strcmp(answer, '') == 1
                                app.OutputLabel.Text = 'Please, insert a valid name!';
                                return;
                        else
                                app.OutputLabel.Text= sprintf('%s\n%s',"Welcome " + answer+ ...
                                        "!","Now I will take "+ string(num)+ " snapshots.");
        
                                defaultDB = 'database';
                                currentDir = pwd();
                                dbPath = fullfile(currentDir, defaultDB);
                                res = registerClient(app, dbPath);
                                % possibly handle the res < 0 condition
                        end
                case 'verification'

                case 'identification'
                        [res] = identifyClient(app, app.InputEditField.Value);
                otherwise
                        warning('Invalid callRoutine');
        end
end