function updateRegisterPanel(app)
        switch app.operation
                case 'registration'
                        % Enter your name and register your face within the database
                        app.UIFigure.Pointer = 'arrow';
                        app.InteractivePanel.Visible = true;
                        app.InputEditFieldLabel.Text = "Enter Your Name:";
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                        app.StartButton.Enable = true;
                        app.GoBackButton.Enable = true;
                case 'identification'
                        app.InteractivePanel.Visible = true;
                        app.InputEditFieldLabel.Text = "Select a person to identify from the DB [1-41]:";
                        app.OutputLabel.Text = 'I Will identify the person you choose.';
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                case 'verification'
                        app.InteractivePanel.Visible = true;
                        app.InputEditFieldLabel.Text = "Declare your Identity with respect to the DB [1-41]:";
                        app.OutputLabel.Text = 'I Will verify you identity.';
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                otherwise
                        warning('Unexpected operation');
        end
 
end        
        
      