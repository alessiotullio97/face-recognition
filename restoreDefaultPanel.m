function restoreDefaultPanel(app)
        app.InteractivePanel.Visible = false;
        app.InputEditFieldLabel.Text = '';
        app.InputEditFieldLabel.Visible = true;
        app.InputEditField.Visible=true;
        app.OutputLabel.Text = '';
        app.InputEditField.Value = '';
        app.OutputLabel.FontColor='black';
        app.IdentificationModeButton.Enable = true;
        app.VerificationModeButton.Enable = true;
        app.RegisterYourselvesButton.Enable = true;
        app.PersonListDropDown.Visible = false;
        app.UIAxes.Visible=false;
        app.himg.Visible=false;
        app.Panel.Visible=false;
        app.StartButton.Enable=true;
end