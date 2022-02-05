# Questions
	1. Classifier: how do we train the classifier with positive and negative
	example?

BEAWARE:
	In identification closed set there is no Acceptance threshold

1. Aumento tempo campionamento/Selezione campione più significativi 
per aumentare differenza samples. (Dire all'utente di fare diverse espressioni facciali).
	[v]
2. Hog Feature su bocca, naso, occhi
	trying to fix the pseudocode
	[v]
3. Verifica prestazioni (FER, FAR, EER, ROC)
Attenzione sul FAR: identity falsa può venire sia da un impostore esterno che interno.


4. CMC per identification closed set.


// Pay attention here
5. Gallery: image set for identification/verification != dataset
testing = gallery | probes
training

# PROJECT OBJECTIVES:
Design and implementation of a face recognition biometric module using MATLAB.

## Biometric System Steps

1. face capture and possible image enhancement


### VIOLA JONES
2. face localization

3. possible cropping of 1+ regions of interests (ROIs)

The image has to be converted into a 256-RGB color map of size w x h.
A vector of size n = w x h can be constructed from the map.

Be aware of "Curse of Dimensionality problem" (the lower the resolution the 
better the results).

4. Components Identification (eyes, nose, mounth, ...)

5. Normalization
Normalization (both geometrical and photometric to obtain a canonical form)

### HOG Feauture extractions
6. Feature Extraction
Data -> Feature Extraction -> Storage (set of templates)
Hog Feature extractions: https://www.mathworks.com/help/vision/ref/extracthogfeatures.html
			 https://www.mathworks.com/matlabcentral/answers/93148-why-do-i-receive-the-error-attempt-to-execute-script-filename-as-a-function
Generalization: the training results has to improve the system recognition.
Training sample should be different from one of the gallery to increase generalization.

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
IMPORTANT: another source of the code at  https://codetobuy.com/downloads/matlab-code-for-face-recognition-based-on-histogram-of-oriented-gradients-hog/

open dataset: http://vintage.winklerbros.net/facescrub.html

url: https://www.upgrad.com/blog/matlab-application-in-face-recognition/

MathLab, image-recognition: https://it.mathworks.com/discovery/image-recognition-matlab.html

Interesting Paper: http://www.warse.org/IJATCSE/static/pdf/file/ijatcse17842019.pdf
                   https://www.researchgate.net/publication/274521637_A_Review_Of_Face_Recognition_Methods -> for face recognition [no cap 6]
                   http://www.arpnjournals.org/jeas/research_papers/rp_2016/jeas_1216_5414.pdf -> for face detection
Nice to Look for Inspiration: https://vision.csee.wvu.edu/publications/

AT&T Face Database: https://www.kaggle.com/kasikrit/att-database-of-faces

https://drive.google.com/file/d/12QkorMzXDtJ0C4xMXMfWod2-cgFJDqZP/view
