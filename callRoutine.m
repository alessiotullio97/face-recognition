function callRoutine(app)
        switch app.operation
                case 'registration'
                        defaultDB = 'database';
                        currentDir = pwd();
                        dbPath = fullfile(currentDir, defaultDB);
                        res = registerClient(app, dbPath);
                        % possibly handle the res < 0 condition
                case 'verification'

                case 'identification'
                        [res] = identifyClient(app, app.EnterYourNameEditField.Value);
                otherwise
                        warning('Invalid callRoutine');
        end
end