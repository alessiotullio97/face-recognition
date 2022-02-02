function [result] = registerClient(app, dbPath)
        n = 10; % #snapshots
        person = app.InputEditField.Value;
        app.StartButton.Enable = false;
        app.OutputLabel.Text= sprintf('%s\n%s\n%s',"The operation will take some times.", ...
            "HINT: Try to move a little to take better snapshots",...
                "Please wait until it is finished!");
        app.UIFigure.Pointer = 'watch';

        dbPersonPath = takePersonPath(dbPath, person);

        % Create the face detector object.
        faceDetector = vision.CascadeObjectDetector();
        
        % Create the point tracker object.
        pointTracker = vision.PointTracker('MaxBidirectionalError', 2);    
        % Create the webcam object.
        if exist('cam') == 0
                app.Camera = webcam;
        end
        
        % Capture one frame to get its size.
        app.UIAxes.Visible=true;
        app.himg=image(app.UIAxes,zeros(size(snapshot(app.Camera)),'uint8'));
        videoPlayer=preview(app.Camera,app.himg);
        videoFrame = snapshot(app.Camera);
        frameSize = size(videoFrame);
        runLoop = true;
        numPts = 0;
        
        frameCount = 0;

        iterationForSnap = 100;
        maxFrameCount = iterationForSnap * n;
        j = 1;
        
        result = 0; % result indicates all snapshots has been taken correctly
        while runLoop && frameCount < maxFrameCount && result == 0
        
                % Get the next frame.
                videoFrame = snapshot(app.Camera);
                
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
                                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);
                    
                                % Display tracked points.
                                videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');
                    
                                % Reset the points.
                                oldPoints = visiblePoints;
                                setPoints(pointTracker, oldPoints);
                        end   
                end
            
                % Evert 'iterationForSnap' save the snap within the
                % database
                if mod(frameCount, iterationForSnap) == 0
                        result = saveSnap(videoFrameGray, bboxPolygon, dbPersonPath, j, app);
                        app.OutputLabel.Text= sprintf('%s\n%s\n%s',"The operation will take some times.","Please wait until it is finished!", j +" snapshot of 10 taken");
                        j = j + 1;
                end
        end
        app.UIFigure.Pointer = 'arrow';
        
        % Train the system again
        if result == 0 && ttSystem(app) == 0
            
                app.OutputLabel.Text = "Operation completed successfully!";
                %% MODIFY: Show all snapshots taken for registered person
%                 figure(1);
%                 montage(app.faceDatabase(j).ImageLocation);
%                 title('Set of snapshots taken for ' + person)
        else
                app.OutputLabel.FontColor = 'red';
                app.OutputLabel.Text = 'Unable to take 10 snapshots';
        end

        % Clean up.
        clear app.Camera;
        release(pointTracker);
        release(faceDetector);
        app.InputEditField.Visible = false;
        app.InputEditFieldLabel.Visible = false;
        app.UIAxes.Visible=false;
        app.himg.Visible=false;
        app.IdentificationModeButton.Enable = true;
        app.VerificationModeButton.Enable = true;
        app.RegisterYourselvesButton.Enable = true;
        app.Panel.Visible=true;
end