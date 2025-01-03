function [colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions)
    %intilize image height width and d metrix
    [height, width, d] = size(origIm);
    %calculate color label image
    colorLabelIm = reshape(kmeans(im2double(reshape(origIm, height * width, d)), numColorRegions), height, width);

    %calculate texture label image
    textonHist = extractTextonHists(rgb2gray(origIm), bank, textons, winSize);
    textureLabelIm = reshape(kmeans(im2double(reshape(textonHist, height * width, size(textonHist, 3))), numTextureRegions), height, width);
end
