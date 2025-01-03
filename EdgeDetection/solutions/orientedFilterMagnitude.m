function [mag, theta] = orientedFilterMagnitude(im)
    %take an RGB image as input
    image = rgb2hsv(im);
    %set sigma value
    sigma = 3;
    %calculate two derived gaussians with two dimensional x and y
    [dx, dy] = gradient(fspecial('gaussian', 20, sigma));

    % build there pair filter that use m mean minus
    dm60 = dx * cosd(-60) + dy * sind(-60);
    d60 = dx * cosd(60) + dy * sind(60);
    dm30 = dx * cosd(-30) + dy * sind(-30);
    d30 = dx * cosd(30) + dy * sind(30);
    d45 = dx * cosd(45) + dy * sind(45);
    dm45 = dx * cosd(-45) + dy * sind(-45);

    %calculate four different gaussian derivative filter on image
    Gaussian_x1 = double(imfilter(image, dx, 'replicate', 'conv'));
    Gaussian_y1 = double(imfilter(image, dy, 'replicate', 'conv'));
    Gaussian_x2 = double(imfilter(image, d45, 'replicate', 'conv'));
    Gaussian_y2 = double(imfilter(image, dm45, 'replicate', 'conv'));
    Gaussian_x3 = double(imfilter(image, d30, 'replicate', 'conv'));
    Gaussian_y3 = double(imfilter(image, dm60, 'replicate', 'conv'));
    Gaussian_x4 = double(imfilter(image, d60, 'replicate', 'conv'));     
    Gaussian_y4 = double(imfilter(image, dm30, 'replicate', 'conv'));
    % directly compute image, as a result there is no way to compute theta
    temp1 = sqrt(Gaussian_x1.^2 + Gaussian_y1.^2);
    temp2 = sqrt(Gaussian_x2.^2 + Gaussian_y2.^2);
    temp3 = sqrt(Gaussian_x3.^2 + Gaussian_y3.^2);
    temp4 = sqrt(Gaussian_x4.^2 + Gaussian_y4.^2);
    %sum all temp, find max and calculate theta
    mag= temp1 + temp2 + temp3 + temp4;
    [mag, ] = max(sqrt(mag), [], 3);
    theta = zeros(size(im, 1), size(im, 2));
end
