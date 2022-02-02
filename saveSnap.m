function [result] = saveSnap(videoFrameGray, bboxPolygon, path, j,app)

        position1 = min(bboxPolygon(2),bboxPolygon(4));
        position2 = max(bboxPolygon(6),bboxPolygon(8));
        position3 = min(bboxPolygon(1),bboxPolygon(7));
        position4 = max(bboxPolygon(3),bboxPolygon(5));
        
        warning('off')
        getimage = videoFrameGray(position1:position2,position3:position4,:);
        app.ax=uiaxes(app.Panel);
        app.ax.Visible=false;
        if(j<=5)
                i=j-1
                x=1+i*160;
                y=125;
                w=160;
                z=270;
        else 
                i=j-6
                x= 1+i*160;
                y=0;
                w=160;
                z=270;
        end
        app.ax(j)=uiaxes(app.Panel, 'Position', [x,y,w,z]);
        app.ax(j).Colormap = [1 0 1; 0 0 1; 1 1 0];
       
        imshow(getimage, 'parent', app.ax(j));

  
        
        

        % resize image
        image1 = imresize(getimage, app.defaultImSIze);
        
        fileName = sprintf("%d.pgm", j);
        photoPath = fullfile(path, fileName);
        
        try
                imwrite(image1, photoPath);
                result = 0;
        catch
                warning(['Failed to write image into ' photoPath '']);
                result = -1;
        end
end