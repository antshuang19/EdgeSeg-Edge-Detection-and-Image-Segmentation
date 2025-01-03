function bmap = edgeGradient( im )   
    %set sigma value
    sigma = 3;
    %compute a soft boundary map and then perform nonmaxima suppression.
    [image, theta] = gradientMagnitude(im, sigma);
    %the boundary scores can be rescaled,
    imageB = image.^0.7;
    %to perform non-maxima suppression by using canny
    edges = edge(rgb2gray(im), 'canny');
    bmap = imageB .* edges;
end