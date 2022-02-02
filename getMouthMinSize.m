function getMouthMinSize(app)
        m = 200;
        n = 200;
        
        %To detect Mouth
        if(app.mdPresent == 0)
                mouthTh = 16;
                app.MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',mouthTh);
                app.mdPresent = 1;
        end        
        % Iterate over app.training set
        for i = 1:size(app.training, 2)
                for j = 1:app.training(i).Count
                        I = read(app.training(i), j);
                        BB = step(app.MouthDetect,I);
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
                        BB = step(app.MouthDetect,I);
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

        app.mouthResizedSize = [m, n];
        
        I = read(app.training(1), 1);
        BB = step(app.MouthDetect,I);
        Icropped = imcrop(I, BB);
        Iresized = imresize(Icropped, app.mouthResizedSize);
        [r, c] = size(extractHOGFeatures(Iresized));
        app.mouthFeatureSize = r*c;
end