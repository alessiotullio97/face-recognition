function [result] = saveSnap(videoFrameGray, bboxPolygon, path, j)

        position1 = min(bboxPolygon(2),bboxPolygon(4));
        position2 = max(bboxPolygon(6),bboxPolygon(8));
        position3 = min(bboxPolygon(1),bboxPolygon(7));
        position4 = max(bboxPolygon(3),bboxPolygon(5));
        
        warning('off')
        getimage = videoFrameGray(position1:position2,position3:position4,:);
        imshow(getimage);
        
        % resize image
        image = imresize(getimage, [300 300]);
        
        % Modify here. In the folder database2, label the name of ppl and put their
        % faces inside the folder.
        format = '.pgm';
        fileName = sprintf("%d.pgm", j);

        photoPath = fullfile(path, fileName);
        try
                imwrite(image, photoPath);
                result = 0;
        catch
                warning(['Failed to write image into ' photoPath '']);
                result = -1;
        end
end