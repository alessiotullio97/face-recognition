function restoreDefaultPanel(app)
        app.InteractivePanel.Visible = false;
        app.InputEditFieldLabel.Text = '';
        app.OutputLabel.Text = '';
        app.InputEditField.Value = '';

        app.IdentificationModeButton.Enable = true;
        app.VerificationModeButton.Enable = true;
        app.RegisterYourselvesButton.Enable = true;
end