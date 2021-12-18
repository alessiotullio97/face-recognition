function [result] = registerClient(app)
        % Enter your name and register your face within the database
        app.RegisterYourselvesPanel.Visible = true;
        answer = app.EnterYourNameEditField.Value;
        app.IdentificationModeButton.Enable=false;
        app.VerificationModeButton.Enable=false;
        app.RegisterYourselvesButton.Enable=false;
        num = 10;
        app.Label.Text= sprintf('%s\n%s',"Welcome " + answer+ "!","Now I will take "+ string(num)+ " snapshots.");
 
return;   
        
        
      