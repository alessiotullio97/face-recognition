# PROJECT OBJECTIVES:
Design and implementation of a face recognition biometric module using MATLAB.

## Biometric System Steps

// The following has to be refined according to the final implementation 

1. face capture and possible image enhancement
2. face localization
3. possible cropping of 1+ regions of interests (ROIs)

The image has to be converted into a 256-RGB color map of size w x h.
A vector of size n = w x h can be constructed from the map.

Be aware of "Curse of Dimensionality problem" (the lower the resolution the 
better the results).

4. Components Identification (eyes, nose, mounth, ...)
5. Normalization
Normalization (both geometrical and photometric to obtain a canonical form)
6. Feature Extraction
Data -> Feature Extraction -> Storage (set of templates)
Hog Feature extractions: https://www.mathworks.com/help/vision/ref/extracthogfeatures.html

Generalization: the training results has to improve the system recognition.

7. Template construction
8. Matching
extracted feature + template feature -> matching score -> decision?


### Module Specifications
- To Define...


## RERPORT:
- A detailed report of the project

### Report Specification
[] external sources that were used
[] "original" (i.e. the improved or created one) code to build the final application. 
[] Perfomance Evaluation

## PRESENTATION:
A presentation in powerpoint or whatever and a demo must be prepared to present the
project.

### Presentation Specs
underline any design choice you had to make in order to have:
[] the application work
[] clear architecture structure to highlight the parts of code taken from libraries
and the part of code developed by you.

## PERFOMANCE EVALUATION:
You have to carry out a through performance evaluation, possibly in
verification mode, and results must be reported in the report.


## External Resources
open dataset: http://vintage.winklerbros.net/facescrub.html

url: https://www.upgrad.com/blog/matlab-application-in-face-recognition/

MathLab, image-recognition: https://it.mathworks.com/discovery/image-recognition-matlab.html

Interesting Paper: http://www.warse.org/IJATCSE/static/pdf/file/ijatcse17842019.pdf
                   https://www.researchgate.net/publication/274521637_A_Review_Of_Face_Recognition_Methods -> for face recognition [no cap 6]
                   http://www.arpnjournals.org/jeas/research_papers/rp_2016/jeas_1216_5414.pdf -> for face detection
Nice to Look for Inspiration: https://vision.csee.wvu.edu/publications/
