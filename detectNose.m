function [BB, res] = detectNose(I, app)
        try
                if(app.ndPresent == 0)
                        noseThreshold = 16;
                        %To detect Nose
                        app.NoseDetect = vision.CascadeObjectDetector('Nose', 'MergeThreshold', noseThreshold);
                end
                
                BB = step(app.NoseDetect,I);
                
                if(isempty(app.BB))
                        res = -1;
                else
                        res = 0;
                end
        catch
                BB = [];
                res = -1;
        end
end