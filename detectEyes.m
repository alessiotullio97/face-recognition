function [BB, res] = detectEyes(I, app)
        try
                %To detect Eyes
                if(app.edPresent == 0)
                        app.EyesDetect = vision.CascadeObjectDetector('EyePairBig');        
                        app.edPresent = 1;
                end
                
                BB = step(app.EyesDetect, I);
                
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