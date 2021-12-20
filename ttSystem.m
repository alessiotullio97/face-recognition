%% function TTsystem
% Training and Testing the system
function [res] = ttSystem(app)
        try
                % Load Image Information from ATT Face Database Directory
                app.faceDatabase = imageSet('database','recursive');
                
                % Split Database into Training & Test Sets
                [app.training, app.test] = partition(app.faceDatabase, [0.8 0.2]);
                       
                %% Extract HOG Features for training set 
                app.trainingFeatures = zeros(size(app.training, 2) * app.training(1).Count, 4680);
                
                featureCount = 1;
                for i = 1:size(app.training, 2)
                        for j = 1:app.training(i).Count
                                app.trainingFeatures(featureCount,:) = extractHOGFeatures( ...
                                        read(app.training(i), j));
                                app.trainingLabel{featureCount} = app.training(i).Description;    
                                featureCount = featureCount + 1;
                        end
                        app.personIndex{i} = app.faceDatabase(i).Description;
                end
                res = 0;
        catch
                warning('Unable to train the System');
                res = -1;
        end
end
