function [mag, theta] = gradientMagnitude(im, sigma)
    %Should take an RGB image as input
    im = rgb2hsv(im);
    %smooth the image with Gaussian std=sigma
    smooth_image = imgaussfilt(im, sigma);
    % compute the x and y gradient values of the smoothed image
    [Gaussian_x, Gaussian_y] = gradient(smooth_image);

    %compute the gradient magnitude of an RGB image by taking the L2-norm of the R, G, and B gradients
    mag = sqrt(Gaussian_x.^2 + Gaussian_y.^2);
    sin_theta = Gaussian_x ./ mag;
    cos_theta = Gaussian_y ./ mag;
    thetas = atan(sin_theta ./ cos_theta) + (pi .* sign(sin_theta)) .* sign(-cos_theta);
    %The orientation can be computed from the channel corresponding to the largest gradient magnitude
    %theree dimensional
    [value, Midx] = max(mag, [], 3);
    theta = zeros(size(im, 1), size(im, 2));

    for i = 1:3
        theta = theta + thetas(:, :, i) .* (Midx == i);
    end
    %The overall gradient magnitude is the L2-norm of the x and y gradients.
    mag = sqrt(sum(mag.^2, 3));
end
