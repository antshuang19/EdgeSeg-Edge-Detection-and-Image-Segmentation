function [featIm] = extractTextonHists(origIm, bank, textons, winSize)
    %intilize height width etc
    [m, m, d] = size(bank);
    [height, width] = size(origIm);
    [k, d] = size(textons);

    %intilize filtere_image and feat_image
    featIm = zeros(height, width, k);
    filtere_Image = zeros(height, width, d);

    %loop to iterate every image and apply filter on it
    for i = 1:d
        filtere_Image(:, :, i) = imfilter(origIm, bank(:, :, i));
    end
    % use quantisizefeat to get label_image
    label_image = quantizeFeats(filtere_Image, textons);

    %two for loop to calculate freq on texton
    for i = 1:height
        for j = 1:width
            w = label_image(max(i - fix(winSize / 2), 1):min(i + fix(winSize / 2), height), max(j - fix(winSize / 2), 1):min(j + fix(winSize / 2), width));
            unq = unique(w);
            freq = [unq, histc(w(:), unq)];
            featIm(i, j, freq(:, 1)) = freq(:, 2);
        end
    end

end
