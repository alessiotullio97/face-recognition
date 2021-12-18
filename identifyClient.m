function [res] = identifyClient(app)
        
        res = -1;
        % Create 40 class classifier using  
        faceClassifier = fitcecoc(app.trainingFeatures, app.trainingLabel);
        
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
        
        n = 5;          % number of photo
        iterationForSnap = 10;
        maxFrames = iterationForSnap * n; 
        
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
                        
                        if numPts >= 10 && (frameCount, iterationForSnap) == 0 %% perform the snap every iterationForSnap steps
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

                                position1 = min(bboxPolygon(2),bboxPolygon(4));
                                position2 = max(bboxPolygon(6),bboxPolygon(8));
                                position3 = min(bboxPolygon(1),bboxPolygon(7));
                                position4 = max(bboxPolygon(3),bboxPolygon(5));
                
                                warning('off')
                                %if position2<640 && position4<640 && position1>0 && position2>0
                                        getimage = videoFrameGray(position1:position2,position3:position4,:);
                
                                        %resize image
                                        getimage = imresize(getimage, [112 92]);
                                        
                                        queryFeatures = extractHOGFeatures(getimage);
                
                                        [personLabel,PostProbs]  = predict(faceClassifier, queryFeatures);
                                        maxpro = max(abs(PostProbs(1)),abs(PostProbs(2)));
                                        position = [position3 position2];
                                        box_color = {'yellow'};
                                        string = strcat(personLabel,num2str(maxpro));
                                        videoFrame = insertText(videoFrame,position,string,'FontSize', ...
                                            18,'BoxColor',...
                                        box_color,'BoxOpacity',0.4,'TextColor','white');

                                        % Show identified Person
                                        figure;
                
                                        subplot(2, 1, 1);
                                        imshow(getimage);
                                        title('Input Face');
                                        
                                        subplot(2,1,2);
                                        recognizedFace = getFaceFromDB(personLabel{1});
                                        imshow(recognizedFace);
                                        title(string);
                                        % pause(10);
                                %end
                        end
                end
                                
                % Display the annotated video frame using the video player object.
                step(videoPlayer, videoFrame);
        
                % Check whether the video player window has been closed.
                runLoop = isOpen(videoPlayer);
        end

        res = 0;

        % Clean up.
        clear cam;
        release(videoPlayer);
        release(pointTracker);
        release(faceDetector);
end