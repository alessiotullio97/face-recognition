function restoreDefaultPanel(app)
        %app.PanelAxes.Visible=false;
        app.UIAxes2.Visible=false;
        app.Panel_2.Visible=false;
        app.UIAxes4.Visible=false;
        app.UIAxes3.Visible=false;

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