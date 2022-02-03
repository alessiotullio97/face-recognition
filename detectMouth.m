function [BB, res] = detectMouth(I, app)
        try
                %To detect Mouth
                if(app.mdPresent == 0)
                        mouthTh = 16;
                        app.MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold', mouthTh);
                        app.mdPresent = 1;
                end   
                
                BB = step(app.MouthDetect, I);
                
                if(isempty(BB))
                        res = -1;
                else
                        BB = BB(1,:);
                        res = 0;
                end
        catch
                BB = [];
                res = -1;
        end
end