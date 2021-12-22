function [res] = identifyClient(app, person)
        try
                warning('off')
                if person < 1 || person > app.dbSize
                        app.OutputMessage.Text = 'You must specify a value between 1 and ' + string(app.dbSize);
                        return;
                end

                if app.faceClDefined == 0
                        app.faceClassifier = fitcecoc(app.trainingFeatures, app.trainingLabel);
                        app.faceClDefined = 1;
                end

                queryImage = read(app.test(person), 1);
                queryFeatures = extractHOGFeatures(queryImage);
                personLabel = predict(app.faceClassifier, queryFeatures);

                % Map back to training set to find identity
                booleanIndex = strcmp(personLabel, app.personIndex);
                matchedIndex = find(booleanIndex);
                
                subplot(1,2,1);
                imshow(queryImage);
                title( "Query Face - s" + string(person));
                subplot(1,2,2);
                imshow(read(app.training(matchedIndex),1));
                title("Matched Class - s" + string(matchedIndex));
                res = 0;
        catch
                res = -1;
                warning('Unable to recognize s' + person);
        end
end