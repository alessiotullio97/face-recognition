function [result] = betaRegisterClient()
        prompt = "What's your name?";
        
        % dialog box ask your name and get your answer
        answer = inputdlg(prompt);
        
        % numeber of screeshots to be performed
        num = 10;
        
        % dialog box showing your name taken
        f = msgbox(['Welcome ' answer{1} '! Now I will take ' string(num) ...
                ' snapshots.']);
        
        defaultDB = 'database';
        currentDir = pwd();
        dbPath = fullfile(currentDir, defaultDB);
        
        try
                result = takeSnapshots(answer{1}, dbPath, num);
        catch
                warning("Unable to take 10 snapshots.");
                result = -1;
        end
end