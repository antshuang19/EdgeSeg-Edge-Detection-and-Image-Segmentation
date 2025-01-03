function bmap = edgeOrientedFilters(im)
    % to compute a soft boundary map
    [image, theta] = orientedFilterMagnitude(im);
    %the boundary scores can be rescaled
    imageB = image.^0.7;
    edges = edge(rgb2gray(im), 'canny');
    %to perform non-maxima suppression by using canny
    bmap = imageB .* edges;
end