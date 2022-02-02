function cropSection = cropImage(I, BB, resizedSize)
        cropSection = imresize(imcrop(I, BB), resizedSize);
end