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
                
                subplot(1,2,1);
                imshow(queryImage);
                title( "Query Face - " + personName);
                subplot(1,2,2);

                imshow(read(app.training(matchedIndex),1));
                title("Matched Class - " + getRelativeName(matchedIndex));
                res = 0;
        catch
                res = -1;
                warning('Unable to recognize s' + string(personId));
        end
end