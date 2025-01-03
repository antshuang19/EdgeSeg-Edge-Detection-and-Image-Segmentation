
% load the image 
gumballs = imread('gumballs.jpg');
snake = imread('snake.jpg');
twins = imread('twins.jpg');
coins = imread('coins.jpg');
load('filterBank.mat');

%put the image to the stack and make rgb gray
image_stack = {rgb2gray(gumballs), rgb2gray(snake), rgb2gray(twins), rgb2gray(coins)};

%generate textons
textons = createTextons(image_stack, F, 10); 

% snake image procces
[color_Label_Image, texture_Label_Image] = compareSegmentations(snake, F, textons, 5, 3, 6); 
subplot(1, 3, 1);
imshow(snake);
title('Original images');
subplot(1, 3, 2);
imshow(label2rgb(color_Label_Image));
title('Color labeled snake with 3');
subplot(1, 3, 3);
imshow(label2rgb(texture_Label_Image));
title('Texture labeled snake with 6');

% % twins image procces
[color_Label_Image, texture_Label_Image] = compareSegmentations(twins, F, textons, 15, 6, 7);
subplot(1, 3, 1);
imshow(twins);
title('Original twins image');
subplot(1, 3, 2);
imshow(label2rgb(color_Label_Image));
title('Color labeled twins with 6');
subplot(1, 3, 3);
imshow(label2rgb(texture_Label_Image));
title('Texture labeled twins with 7');

% % gumballs image procces
[color_Label_Image, texture_Label_Image] = compareSegmentations(gumballs, F, textons, 12, 10, 4); 
subplot(1, 3, 1);
imshow(gumballs);
title('Original gumballs image');
subplot(1, 3, 2);
imshow(label2rgb(color_Label_Image));
title('Color labeled gumballs with 10');
subplot(1, 3, 3);
imshow(label2rgb(texture_Label_Image));
title('Texture labeled gumballs with 4');

% % coins
[colorLabelIm, textureLabelIm] = compareSegmentations(coins, F, textons, 9, 5, 4); 
subplot(1, 3, 1);
imshow(coins);
title('Original coins image');
subplot(1, 3, 2);
imshow(label2rgb(colorLabelIm));
title('Color labeled coins with 5 ');
subplot(1, 3, 3);
imshow(label2rgb(textureLabelIm));
title('Texture labeled coins with 4 ');

% snake different window size
[coloLabelIm1, textureLabelIm1] = compareSegmentations(snake, F, textons, 4, 6, 7);
[colorLabelIm2, textureLabelIm2] = compareSegmentations(snake, F, textons, 26, 6, 7);
subplot(1, 3, 1);
imshow(snake);
title('Original twins image');
subplot(1, 3, 2);
imshow(label2rgb(textureLabelIm1));
title('Texture labeled -> window size 4');
subplot(1, 3, 3);
imshow(label2rgb(textureLabelIm2));
title('Texture labeled -> window size 26');

% use diff filter
subsetF = F(:, :, 3:5) + F(:, :, 9:11) + F(:, :, 15:17) + F(:, :, 21:23) + F(:, :, 27:29) + F(:, :, 33:35);

%build generate textons
textons1 = createTextons(imStack, F, 10);
textons2 = createTextons(imStack, subsetF, 10);

[colorLabelIm1, textureLabelIm1] = compareSegmentations(snake, F, textons1, 15, 6, 7);
[colorLabelIm2, textureLabelIm2] = compareSegmentations(snake, subsetF, textons2, 15, 6, 7);
subplot(1, 3, 1);
imshow(snake);
title('Original snake images');
subplot(1, 3, 2);
imshow(label2rgb(textureLabelIm1));
title('snake with all filters');
subplot(1, 3, 3);
imshow(label2rgb(textureLabelIm2));
title('snake with vertical filters');
