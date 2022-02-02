function [res] = identifyClient(app, personId, personName)


        try
                warning('off')
                if personId < 1 || personId > app.dbSize
                        app.OutputLabel.FontColor='red';
                        app.OutputMessage.Text = 'You must specify a value between 1 and ' + string(app.dbSize);
                        return;
                end

                if app.faceClDefined == 0
                        app.faceClassifier = fitcecoc(app.trainingFeatures, app.trainingLabel);
                        app.faceClDefined = 1;
                end

                queryImage = read(app.test(personId), 1);
                queryFeatures = extractSeparatedHOGFeatures(queryImage);
                personIdLabel = predict(app.faceClassifier, queryFeatures);

                % Map back to training set to find identity
                booleanIndex = strcmp(personIdLabel, app.personIndex);
                matchedIndex = find(booleanIndex);
                app.PanelAxes.Visible=true;
                app.UIAxes2.Visible=true;
                app.UIAxes4.Visible=true;
                imshow(queryImage, 'parent',app.UIAxes2);
                title( "Query Face - " + personName,'parent',app.UIAxes2);
                title("Matched Class - " + getRelativeName(matchedIndex), 'parent', app.UIAxes4);
                matchedImage=read(app.training(matchedIndex),1);
                imshow(matchedImage, 'parent', app.UIAxes4);
                app.OutputLabel.Text = "Person identified!";
                app.UIFigure.Pointer = 'arrow';
                res = 0;
            
                
        catch
                res = -1;
                warning('Unable to recognize s' + string(personId));
        end
end