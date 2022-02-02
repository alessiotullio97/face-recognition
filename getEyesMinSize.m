function getEyesMinSize(app)
        m = 200;
        n = 200;
        
        %To detect Eyes
        if(app.edPresent == 0)
                app.EyeDetect = vision.CascadeObjectDetector('EyePairBig');        
                app.edPresent = 1;
        end
        % Iterate over app.training set
        for i = 1:size(app.training, 2)
                for j = 1:app.training(i).Count
                        I = read(app.training(i), j);
                        BB = step(app.EyeDetect,I);
                        if(~isempty(BB))
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
                        BB = step(app.EyeDetect,I);
                        if(~isempty(BB))
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

        app.eyesResizedSize = [m, n];
        
        I = read(app.training(1), 1);
        BB = step(app.EyeDetect,I);
        Icropped = imcrop(I, BB);
        Iresized = imresize(Icropped, app.eyesResizedSize);
        [r, c] = size(extractHOGFeatures(Iresized));
        app.eyesFeatureSize = r*c;
end