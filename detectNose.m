function [BB, res] = detectNose(I, app)
        try
                %To detect Nose
                if(app.ndPresent == 0)
                        noseThreshold = 16;
                        app.NoseDetect = vision.CascadeObjectDetector('Nose', 'MergeThreshold', noseThreshold);
                end
                
                BB = step(app.NoseDetect, I);
                
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