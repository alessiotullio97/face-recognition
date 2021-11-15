

img = imread('archive/s1/1.pgm');

[featureVector,hogVisualization] = extractHOGFeatures(img);

figure;
imshow(img); 
hold on;
plot(hogVisualization);