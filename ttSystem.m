%% function TTsystem
% Training and Testing the system
function [res] = ttSystem(app)
        %try
                % Set face classifier to not defined
                app.faceClDefined = 0;
                % Load Image Information from ATT Face Database Directory
                app.faceDatabase = imageSet('database','recursive');
                
                % Split Database into Training & Test Sets (i.e. 8 image to
                % db and 2 to test
                [app.training, app.test] = partition(app.faceDatabase, [0.8 0.2]);
                
                % Get Minimum size for all relevant features
                getMinEyesSize(app);
                getMinNoseSize(app);
                getMinMouthSize(app);
                
                app.featureSize = app.noseFeatureSize + app.eyesFeatureSize + app.mouthFeatureSize;
                %% Extract HOG Features for training set 
                app.trainingFeatures = zeros(size(app.training, 2) * app.training(1).Count, app.featureSize);
                
                featureCount = 1;
                for i = 1:size(app.training, 2)
                        for j = 1:app.training(i).Count
                                I = read(app.training(i), j);
                                app.trainingFeatures(featureCount,:) = extractSeparatedHOGFeatures(I, app);
                                app.trainingLabel{featureCount} = app.training(i).Description;    
                                featureCount = featureCount + 1;
                        end
                        app.personIndex{i} = app.faceDatabase(i).Description;
                end

                app.dbSize = size(app.training, 2);
                res = 0;
        %catch
         %       warning('Unable to train the System');
        %        res = -1;
       % end
end
