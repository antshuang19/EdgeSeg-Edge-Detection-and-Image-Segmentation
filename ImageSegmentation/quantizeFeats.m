function [labelIm] = quantizeFeats(featIm, meanFeats)
    %k × d matrix meanF eats of k cluster centers
    [k, d] = size(meanFeats);
    % intilize height , width and d matrix
    [height, width, d] = size(featIm);
    labelIm = zeros(height, width);
    %loop for find the cluster
    for column = 1:width
        %build a matrix 
        x = reshape(featIm(:, column, :), height, d);
        %save the cluster
        [~, labelIm(:, column)] = min(dist2(x, meanFeats), [], 2);
    end

end
