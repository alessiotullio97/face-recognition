function [res] = verifyClient(app, declaredIdentity)
        try
                if declaredIdentity < 1 || declaredIdentity > app.dbSize
                        app.OutputMessage.Text = 'You must specify a value between 1 and ' + string(app.dbSize);
                        res = -1;
                        return;
                end
                
                % Create the face detector object.
                faceDetector = vision.CascadeObjectDetector();
                
                % Create the point tracker object.
                pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
                
                % Create the webcam object.
                if exist('cam') == 0
                        cam = webcam;
                end
        
                % Capture one frame to get its size.
                videoFrame = snapshot(cam);
                frameSize = size(videoFrame);
                
                % Create the video player object.
                videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), ...
                        frameSize(1)]+30]);
                
                runLoop = true;
                numPts = 0;
                frameCount = 0;
                
                n = 1;          % number of photo
                iterationForSnap = 10;
                maxFrames = iterationForSnap * n; 
        
                inputImage = '';

                while runLoop && frameCount < maxFrames

                        % Get the next frame.
                        videoFrame = snapshot(cam);
        
                        % Get frame to save data to database
                        videoFrameGray = rgb2gray(videoFrame);
                        frameCount = frameCount + 1;
        
                        if numPts < 10
                                % Detection mode.
                                bbox = faceDetector.step(videoFrameGray);
        
                                if ~isempty(bbox)
                                        % Find corner points inside the detected region.
                                        points = detectMinEigenFeatures(videoFrameGray, ...
                                                'ROI', bbox(1, :));
        
                                        % Re-initialize the point tracker.
                                        xyPoints = points.Location;
                                        numPts = size(xyPoints,1);
                                        release(pointTracker);
                                        initialize(pointTracker, xyPoints, videoFrameGray);
        
                                        % Save a copy of the points.
                                        oldPoints = xyPoints;
        
                                        % Convert the rectangle represented as [x, y, w, h] into an
                                        % M-by-2 matrix of [x,y] coordinates of the four corners. This
                                        % is needed to be able to transform the bounding box to display
                                        % the orientation of the face.
                                        bboxPoints = bbox2points(bbox(1, :));
        
                                        % Convert the box corners into the [x1 y1 x2 y2 x3 y3 x4 y4]
                                        % format required by insertShape.
                                        bboxPolygon = reshape(bboxPoints', 1, []);
        
                                        % Display a bounding box around the detected face.
                                        videoFrame = insertShape(videoFrame, 'Polygon', ...
                                                bboxPolygon, 'LineWidth', 3);
        
                                        % Display detected corners.
                                        videoFrame = insertMarker(videoFrame, xyPoints, ...
                                                '+', 'Color', 'white');
                                end
                        else
                                % Tracking mode.
                                [xyPoints, isFound] = step(pointTracker, videoFrameGray);
                                visiblePoints = xyPoints(isFound, :);
                                oldInliers = oldPoints(isFound, :);
        
                                numPts = size(visiblePoints, 1);
        
                                if numPts >= 10
                                        % Estimate the geometric transformation between the old points
                                        % and the new points.
                                        [xform, oldInliers, visiblePoints] = estimateGeometricTransform(...
                                                oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
        
                                        % Apply the transformation to the bounding box.
                                        bboxPoints = transformPointsForward(xform, bboxPoints);
        
                                        % Convert the box corners into the [x1 y1 x2 y2 x3 y3 x4 y4]
                                        % format required by insertShape.
                                        bboxPolygon = reshape(bboxPoints', 1, []);
        
                                        % Display a bounding box around the face being tracked.
                                        videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, ...
                                                'LineWidth', 3);
        
                                        % Display tracked points.
                                        videoFrame = insertMarker(videoFrame, visiblePoints, '+', ...
                                                'Color', 'white');
        
                                        % Reset the points.
                                        oldPoints = visiblePoints;
                                        setPoints(pointTracker, oldPoints);
        
                                        % perform the snap every iterationForSnap steps
                                        if mod(frameCount, iterationForSnap) == 0
                                                position1 = min(bboxPolygon(2), bboxPolygon(4));
                                                position2 = max(bboxPolygon(6), bboxPolygon(8));
                                                position3 = min(bboxPolygon(1), bboxPolygon(7));
                                                position4 = max(bboxPolygon(3), bboxPolygon(5));
        
                                                warning('off')
                                                inputImage = videoFrameGray(position1:position2,position3:position4,:);
        
                                                %resize image
                                                inputImage = imresize(inputImage, [112 92]);
                                        end
                                end
                        end

                        % Display the annotated video frame using the video player object.
                        step(videoPlayer, videoFrame);
        
                        % Check whether the video player window has been closed.
                        runLoop = isOpen(videoPlayer);
                end
        
                if app.faceClDefined == 0
                        app.faceClassifier = fitcecoc(app.trainingFeatures, app.trainingLabel);
                        app.faceClDefined = 1;
                end

                queryFeatures = extractHOGFeatures(inputImage);
                personLabel = predict(app.faceClassifier, queryFeatures);

                if declaredIdentity < 10
                        declaredIdentityLabel = sprintf("s0%d", declaredIdentity);
                else
                        declaredIdentityLabel = sprintf("s%d", declaredIdentity);
                end

                % Map back to training set to find identity
                booleanIndex = strcmp(personLabel, app.personIndex);
                matchedIndex = find(booleanIndex);
                
                subplot(1,3,1);
                imshow(inputImage);
                title( "Query Face - s" + string(declaredIdentity));

                subplot(1,3,2);
                imshow(read(app.training(matchedIndex),1));
                title("Matched Class - s" + string(matchedIndex));
                
                subplot(1,3,3);
                imshow(read(app.training(declaredIdentity),1));
                title("Declared Identity Class - s" + string(declaredIdentity));
                
                if matchedIndex == declaredIdentity
                        app.OutputLabel.Text = 'The system verified your identity!';
                else
                        app.OutputLabel.Text = "You're probably liyng about your real identity, or the system missed it!";
                end

                res = 0;

                % Clean up.
                clear cam;
                release(videoPlayer);
                release(pointTracker);
                release(faceDetector);
        catch
                res = -1;
                warning('Unable to recognize s' + string(declaredIdentity));
        end
end