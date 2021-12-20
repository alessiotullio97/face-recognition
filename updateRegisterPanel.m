function updateRegisterPanel(app)
        switch app.operation
                case 'registration'
                        % Enter your name and register your face within the database
                        app.RegisterYourselvesPanel.Visible = true;
                        app.EnterYourNameLabel.Text = "Enter Your Name:";
                        answer = app.EnterYourNameEditField.Value;
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                        
                        num = 10;
                        app.Label.Text= sprintf('%s\n%s',"Welcome " + answer+ "!","Now I will take "+ string(num)+ " snapshots.");
                case 'identification'
                        app.RegisterYourselvesPanel.Visible = true;
                        app.EnterYourNameLabel.Text = "Select a person to identify from the DB [1-41]:";
                        app.Label.Text = 'I Will identify the person you choose.';
                case 'verificaiton'

                otherwise
                        warning('Unexpected operation');
        end
 
end        
        
      