clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\cameraman.tif');
levels = 3;
% gsize = 3;
% sigma = 0.5;
gsize = 5;
sigma = 30;

[x y]=meshgrid(round(-(gsize-1)/2):round((gsize-1)/2), round(-(gsize-1)/2):round((gsize-1)/2));
gauss = 1/(2*pi*sigma*sigma)*exp(-(x.^2 + y.^2) / (2*sigma*sigma));
gauss = gauss / sum(gauss(:));
im = img;

figure, imshow(uint8(img)); title('Original');

for i = 1:levels
%     im = imfilter(im, gauss);
    [h, w, s] = size(im);

    if s == 3
        im(:,:,1) = gaussian(im(:,:,1), gsize, gauss);
        im(:,:,2) = gaussian(im(:,:,2), gsize, gauss);
        im(:,:,3) = gaussian(im(:,:,3), gsize, gauss);
    elseif s == 1
        im = gaussian(im, gsize, gauss);
    end
    
    if s == 3
        I = zeros(round(h/2),round(w/2),3);
    elseif s == 1
        I = zeros(round(h/2),round(w/2));
    end
    
    for j = 1:2:h
        for k = 1:2:w
            if s == 3
                I(round(j/2),round(k/2),:) = im(j,k,:);
            elseif s == 1
                I(round(j/2),round(k/2)) = im(j,k);
            end
        end
    end
    figure, imshow(uint8(im)); title('Gaussian Pyramid');
    imwrite(uint8(im),['gausspyramid',num2str(i, '%02d'),'.png']);
    disp(size(im));
    im = I;
end

