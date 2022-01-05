function updateRegisterPanel(app)

        switch app.operation
                case 'registration'
                        % Enter your name and register your face within the database
                        close all;
                        app.UIAxes2.Visible=false;
                app.UIAxes4.Visible=false;
                app.UIAxes3.Visible=false;
                        app.UIFigure.Pointer = 'arrow';
                        app.PanelAxes.Visible=false;
                        app.InteractivePanel.Visible = true;
                        app.InputEditFieldLabel.Text = "Enter Your Name:";
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                        app.StartButton.Enable = true;
                        app.GoBackButton.Enable = true;
                        app.Panel_2.Visible=false;
                case 'identification'
                    app.PanelAxes.Visible=false;
                    app.Panel_2.Visible=false;
                    app.UIAxes2.Visible=false;
                app.UIAxes3.Visible=false;
                app.UIAxes4.Visible=false;
                        app.InteractivePanel.Visible = true;
                        app.InputEditFieldLabel.Text = "Select a person to identify";
                        app.InputEditField.Visible = false;
                        app.OutputLabel.Text = 'I Will identify the person you choose.';
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                        updatePersonListBox(app);
                case 'verification'
                    app.Panel_2.Visible=false;
                    app.PanelAxes.Visible=false;
                    app.UIAxes2.Visible=false;
                app.UIAxes4.Visible=false;
                app.UIAxes3.Visible=false;
                        app.InteractivePanel.Visible = true;
                        %app.InputEditFieldLabel.Text = "Declare your Identity with respect to the DB [1-" + app.dbSize + "]:";
                        app.InputEditField.Visible = false;
                        app.InputEditFieldLabel.Text = 'Select your identity';
                        app.OutputLabel.Text = 'I Will verify you identity.';
                        app.IdentificationModeButton.Enable = false;
                        app.VerificationModeButton.Enable = false;
                        app.RegisterYourselvesButton.Enable = false;
                        updatePersonListBox(app);
                otherwise
                        warning('Unexpected operation');
        end
 
end        
        
      