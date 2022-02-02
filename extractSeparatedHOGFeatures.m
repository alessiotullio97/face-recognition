function featureVector = extractSeparatedHOGFeatures(I, app)

        [BB, res] = detectEyes(I, app);
        if(res < 0)
                eyesFeatures(1:app.eyesFeatureSize) = 0;
        else
                eyesSection = cropImage(I, BB, app.eyesResizedSize);
                eyesFeatures(1:app.eyesFeatureSize) = extractHOGFeatures(eyesSection);
        end

        [BB, res] = detectNose(I, app);
        if(res < 0)
                noseFeatures(1:app.noseFeatureSize) = 0;
        else
                NoseSection = cropImage(I, BB, app.noseResizedSize);
                noseFeatures(1:app.noseFeatureSize) = extractHOGFeatures(NoseSection);
        end

        [BB, res] = detectMouth(I, app);
        if(res < 0)
                mouthFeatures(1:app.noseFeatureSize) = 0;
        else
                mouthSection = cropImage(I, BB, app.mouthResizedSize);
                mouthFeatures(1:app.mouthFeatureSize) = extractHOGFeatures(mouthSection);
        end

        % weigth here we = 1 wn = 3 wm = 10;
        featureVector = [eyesFeatures, noseFeatures, mouthFeatures];
end