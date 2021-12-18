%% function TTsystem
% Training and Testing the system
function [res] = ttSystem(app)
        try
                % Load Image Information from ATT Face Database Directory
                faceDatabase = imageSet('database','recursive');
                
                % Split Database into Training & Test Sets
                [training, test] = partition(faceDatabase, [0.8 0.2]);
                       
                %% Extract HOG Features for training set 
                %trainingFeatures = zeros(size(training, 2)*training(1).Count, 46656);
                app.trainingFeatures = zeros(size(training, 2)*training(1).Count, 4680);
                
                featureCount = 1;
                for i=1:size(training,2)
                        for j = 1:training(i).Count
                                points = detectSURFFeatures(read(training(i),j));
                                app.trainingFeatures(featureCount,:) = extractHOGFeatures( ...
                                        read(training(i),j));
                                app.trainingLabel{featureCount} = training(i).Description;    
                                featureCount = featureCount + 1;
                        end
                        personIndex{i} = training(i).Description;
                end
                res = 0;
        catch
                warning('Unable to train the System');
                res = -1;
        end
end
