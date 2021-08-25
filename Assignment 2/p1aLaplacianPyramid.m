clc;
close all;
clear all;

% img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\yellowlily.jpg');
img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\cameraman.tif');
% img = rgb2gray(img);
levels = 3;
% gsize = 3;
% sigma = 0.5;
gsize = 5;
sigma = 100;
[x y]=meshgrid(round(-(gsize-1)/2):round((gsize-1)/2), round(-(gsize-1)/2):round((gsize-1)/2));
gauss = 1/(2*pi*sigma*sigma)*exp(-(x.^2 + y.^2) / (2*sigma*sigma));
gauss = gauss / sum(gauss(:));
im1 = double(img);
figure, imshow(uint8(im1)); title('Original');

for i = 1:levels
    %     figure, imshow(uint8(im1));
%     im2 = imfilter(im1, gauss);
    [h,w,s] = size(im1);
    im2 = zeros(size(im1));
    if s == 3
        im2(:,:,1) = gaussian(im1(:,:,1), gsize, gauss);
        im2(:,:,2) = gaussian(im1(:,:,2), gsize, gauss);
        im2(:,:,3) = gaussian(im1(:,:,3), gsize, gauss);
    elseif s == 1
        im2 = gaussian(im1, gsize, gauss);
    end
    [h, w, s] = size(im2);
    I = zeros(round(h/2),round(w/2),s);
    
    for j = 1:2:h
        for k = 1:2:w
            if s == 3
                I(round(j/2),round(k/2),:) = im2(j,k,:);
            elseif s == 1
                I(round(j/2),round(k/2)) = im2(j,k);
            end
        end
    end
%     disp(size(I));
    [a,b,c] = size(im1);
%     Ibar = imresize(I,2);
    Ibar = imresize(I,[a b]);   
    L = im1-(Ibar);
    figure, imshow(uint8(L)); title('Laplacian Pyramid');
%     disp(size(L));
    imwrite(uint8(L),['laplacianpyramid',num2str(i, '%02d'),'.png']);
    im1 = I;
end

figure, imshow(uint8(I)); title('Laplacian Pyramid');

% G = im2;
% [h,w,s] = size(img);
% G = imresize(G, [h w]);
% for i = 1:levels
%     im = imread(['laplacianpyramid',num2str(i, '%02d'),'.png']);
%     [hbar,wbar,sbar] = size(im);
%     if i == 1
%         sum = im;
%     else
%         sum = imresize(sum,[hbar wbar]);
%         sum(:,:,:) = sum(:,:,:) + im(:,:,:);
%     end
% end
