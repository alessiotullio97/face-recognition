function [result] = saveSnap(videoFrameGray, bboxPolygon, path, j, app)

        position1 = min(bboxPolygon(2),bboxPolygon(4));
        position2 = max(bboxPolygon(6),bboxPolygon(8));
        position3 = min(bboxPolygon(1),bboxPolygon(7));
        position4 = max(bboxPolygon(3),bboxPolygon(5));
        
        warning('off')
        I = videoFrameGray(position1:position2,position3:position4,:);
                
        % resize image
        I = imresize(I, app.defaultImSize);
        
        fileName = sprintf("%d.pgm", j);
        photoPath = fullfile(path, fileName);
        
        try
                imwrite(I, photoPath);
                result = 0;
        catch
                warning(['Failed to write image into ' photoPath '']);
                result = -1;
        end
end