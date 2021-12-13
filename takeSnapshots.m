function [success] = takeSnapshots(person, dbPath, n)

        dbPersonPath = takePersonPath(dbPath, person);

        % Create the face detector object.
        faceDetector = vision.CascadeObjectDetector();
        
        % Create the point tracker object.
        pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
        
        % Create the webcam object.
        % Please, specify your WebCam Here.
        if exist('cam') == 0
                cam = webcam;
        end
        
        % Capture one frame to get its size.
        videoFrame = snapshot(cam);
        frameSize = size(videoFrame);
        
        % Create the video player object.
        videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
        
        runLoop = true;
        numPts = 0;
        frameCount = 0;
        iterationForSnap = 100;
        maxFrameCount = iterationForSnap * n;
        j = 0;
        while runLoop && frameCount < maxFrameCount
        
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
                                points = detectMinEigenFeatures(videoFrameGray, 'ROI', bbox(1, :));
                    
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
                                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
                    
                                % Display detected corners.
                                videoFrame = insertMarker(videoFrame, xyPoints, '+', 'Color', 'white');
                        end
                else % else numPts >= 10
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
                                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
                    
                                % Display tracked points.
                                videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');
                    
                                % Reset the points.
                                oldPoints = visiblePoints;
                                setPoints(pointTracker, oldPoints);
                        end   
                end
            
                % Display the annotated video frame using the video player object.
                step(videoPlayer, videoFrame);
            
                % Check whether the video player window has been closed.
                runLoop = isOpen(videoPlayer);
                if mod(frameCount, iterationForSnap) == 0
                        [snapSuccessJ] = snap(person, dbPersonPath, j);
                        j = j + 1;
                end
        end

        success = true;
        % Clean up.
        clear cam;
        release(videoPlayer);
        release(pointTracker);
        release(faceDetector);
end

function [success] = snap(person, dbPath, j)
        % HINT: could be interesting to create a registration face where you insert
        %       your name and take at maximum 10 snapshot
        position1 = min(bboxPolygon(2),bboxPolygon(4));
        position2 = max(bboxPolygon(6),bboxPolygon(8));
        position3 = min(bboxPolygon(1),bboxPolygon(7));
        position4 = max(bboxPolygon(3),bboxPolygon(5));
        
        warning('off')
        getimage = videoFrameGray(position1:position2,position3:position4,:);
        imshow(getimage);
        
        % resize image
        getimage = imresize(getimage, [300 300]);
        
        % Modify here. In the folder database2, label the name of ppl and put their
        % faces inside the folder.
        format = '.pgm'

        % photoPath = strcat(dbPath, person, j, format);
        photoPath = fullfile(dbPersonPath, j + format);
        imwrite(getimage, photoPath);
        success = true;
end