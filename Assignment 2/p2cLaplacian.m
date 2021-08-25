clc;
close all;
clear all;

%------LAPLACIAN FILTER -----
img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\cameraman.tif');
F3 = fftshift(fft2(img));
[h,w,s] = size(img);
x = round(h/2);
y = round(w/2);

lapf1 = zeros(size(F3));
for i = 1:h
    for j = 1:w
        a = i-x;
        b = j-y;
%           a = i;
%           b = j;
        lapf1(i,j,:) = -(a*a+b*b);
    end
end
% lapf1 = lapf1/(sum(lapf1(:)));

F5a = lapf1.*F3;
img5a = ifft2(ifftshift(F5a));
minVal = min(img5a(:));
img5a(:,:,:) = img5a(:,:,:) - minVal;
maxVal = max(img5a(:));
img5a(:,:,:) = img5a(:,:,:)*255/maxVal;

% figure, imshow(F3);
% figure, imshow(F5a); title('F5a');
figure, imshow(img); title('Original');
figure, imshow(uint8(img5a)); title('Laplacian');

% F5b = ones((size(F3)));
% F5b = F3 + F5a/sum(F5a(:));
% img5b = ifft2(ifftshift(F5b));
% minVal = min(img5b(:));
% img5b(:,:,:) = img5b(:,:,:) - minVal;
% maxVal = max(img5b(:));
% img5b(:,:,:) = img5b(:,:,:)*255/maxVal;

% figure, imshow(F5b);
% figure, imshow(uint8(img5b));
