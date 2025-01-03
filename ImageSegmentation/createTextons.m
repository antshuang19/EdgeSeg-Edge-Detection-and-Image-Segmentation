function [textons] = createTextons(imStack, bank, k)
    %intilize number of image and filter
    %matrix containing d total filters, each of size m × m, and textons is a k × d matrix 
    [~, n] = size(imStack);
    [m, m, d] = size(bank);
    filtered_Image = uint8.empty;
    
    %loop each image 
    for i = 1:n
        %image has height and width
        [height, width] = size(imStack{i});
        filteredIm = zeros(height, width, d);
        %loop for each filter and filter response
        for j = 1:d
            filteredIm(:, :, j) = imfilter(imStack{i}, bank(:, :, j));
        end
        filtered_Image = [filtered_Image; reshape(filteredIm, height * width, d)];
    end
    %choose sample randomly
    [sz_image, ~] = size(filtered_Image);
    s = randi(sz_image, fix(sz / 2000), 1);
    %use algorithm kmean->library
    [~, textons] = kmeans(double(filtered_Image(s, :)), k);
end
