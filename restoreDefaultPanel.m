function restoreDefaultPanel(app)
        app.InteractivePanel.Visible = false;
        app.InputEditFieldLabel.Text = '';
        app.InputEditFieldLabel.Visible = true;
        app.InputEditField.Visible = true;
        app.OutputLabel.Text = '';
        app.InputEditField.Value = '';
        app.OutputLabel.FontColor = 'black';
        app.IdentificationModeButton.Enable = true;
        app.VerificationModeButton.Enable = true;
        app.RegisterYourselvesButton.Enable = true;
        app.PersonListDropDown.Visible = false;

        % clear all related object to UIAxes and set their visibility to
        % false
        cla(app.UIAxes, "reset");
        app.UIAxes.Visible = false;
        app.UIAxesLabel.Text = "";
        app.UIAxesLabel.Visible = false;
%         app.himg.Visible = false;
        app.StartButton.Enable = true;
end