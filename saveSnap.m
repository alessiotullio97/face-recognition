function [success] = saveSnap(videoFrameGray, bboxPolygon, person, dbPath, j)
        % HINT: could be interesting to create a registration face where you insert
        %       your name and take at maximum 10 snapshot
        position1 = min(bboxPolygon(2),bboxPolygon(4));
        position2 = max(bboxPolygon(6),bboxPolygon(8));
        position3 = min(bboxPolygon(1),bboxPolygon(7));
        position4 = max(bboxPolygon(3),bboxPolygon(5));
        
        warning('off')
        getimage = videoFrameGray(position1:position2,position3:position4,:);
        imshow(getimage);
        
        %resize image
        getimage = imresize(getimage, [300 300]);
        
        % Modify here. In the folder database2, label the name of ppl and put their
        % faces inside the folder.
        format = '.jpg'
        photoPath = strcat(dbPath, person, j, format)
        imwrite(getimage,photoPath);
        success = true;
end