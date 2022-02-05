function [res] = identifyClient(app, personId, personName)
        try
                warning('off')
                if personId < 1 || personId > app.dbSize
                        app.OutputLabel.FontColor = 'red';
                        app.OutputMessage.Text = 'You must specify a value between 1 and ' + string(app.dbSize);
                        return;
                end

                if app.faceClDefined == 0
                        app.faceClassifier = fitcecoc(app.trainingFeatures, app.trainingLabel);
                        app.faceClDefined = 1;
                end

                queryImage = read(app.test(personId), 1);
                queryFeatures = extractSeparatedHOGFeatures(queryImage, app);
                personIdLabel = predict(app.faceClassifier, queryFeatures);

                % Map back to training set to find identity
                booleanIndex = strcmp(personIdLabel, app.personIndex);
                matchedIndex = find(booleanIndex);
                matchedImage = read(app.training(matchedIndex), 1);

                app.UIAxes.Visible = true;
                app.UIAxesLabel.Visible = true;
                app.UIAxesLabel.Text = ['Your Input     -      Matched Identity: ' getRelativeName(matchedIndex)];
                montage({queryImage, matchedImage}, 'Size', [1, 2], 'Parent', app.UIAxes);

                if (matchedIndex == personId)
                        app.OutputLabel.FontColor = 'black';
                        app.OutputLabel.Text = "Person correctly identified!";
                else
                        app.OutputLabel.FontColor = 'red';
                        app.OutputLabel.Text = "Person wrongly identified!";
                end
                app.UIFigure.Pointer = 'arrow';
                res = 0;
        catch
                res = -1;
                app.OutputLabel.FontColor = 'red';
                app.OutputLabel.Text = "Unable to identify the person you choose! Try Again.";
                warning('Unable to recognize s' + string(personId));
        end
end