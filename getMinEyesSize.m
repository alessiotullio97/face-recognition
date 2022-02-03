function getMinEyesSize(app)
        m = 200;
        n = 200;
        
        %To detect Eyes
        if(app.edPresent == 0)
                app.EyesDetect = vision.CascadeObjectDetector('EyePairBig');        
                app.edPresent = 1;
        end

        % Iterate over app.training set
        for i = 1:size(app.training, 2)
                for j = 1:app.training(i).Count
                        I = read(app.training(i), j);
                        BB = step(app.EyesDetect,I);
                        if(~isempty(BB))
                                BB = BB(1,:);
                                [r, c] = size(imcrop(I, BB));
                                if (r < m)
                                        m = r;
                                end
                                if (c < n)
                                        n = c;
                                end
                        end
                end
        end

        % Repeat cycle for app.testing
        for i = 1:size(app.test, 2)
                for j = 1:app.test(i).Count
                        I = read(app.test(i), j);
                        BB = step(app.EyesDetect,I);
                        if(~isempty(BB))
                                BB = BB(1,:);
                                [r, c] = size(imcrop(I, BB));
                                if (r < m)
                                        m = r;
                                end
                                if (c < n)
                                        n = c;
                                end
                        end
                end
        end

        app.eyesResizedSize = [m n];
        
        BB = [];
        i = 1;
        j = 1;
        while (isempty(BB))
                I = read(app.training(i), j);
                BB = step(app.EyesDetect, I);
                if(~isempty(BB))
                        BB = BB(1,:);
                        Icropped = imcrop(I, BB);
                        Iresized = imresize(Icropped, app.eyesResizedSize);
                        [r, c] = size(extractHOGFeatures(Iresized, 'CellSize', app.defaultCellSize));
                        app.eyesFeatureSize = r*c;
                end
                i = i + 1;
        end
end