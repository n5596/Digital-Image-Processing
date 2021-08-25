clc;
close all;
clear all;

img1 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\onion.png');

[h1,w1,s1] = size(img1);
% if s1==3
%     img1 = rgb2gray(img1);
% end
center = 0;

H = pow2(floor(log2(h1))+1);
W = pow2(floor(log2(w1))+1);
j = floor((H-h1)/2);
k = floor((W-w1)/2);
 
img = padarray(img1,[j k]);

[h2, w2, s2] = size(img);
if h2 ~= H
    img = padarray(img, [1 0],'post');
end
if w2 ~= W
    img = padarray(img, [0 1],'post');
end
[h w s] = size(img);

img = double(img);

i1 = img(:,:,1);
if s ==3
i2 = img(:,:,2);
i3 = img(:,:,3);
end

f1 = zeros(size(i1));
if s == 3
f2 = zeros(size(i2));
f3 = zeros(size(i3));
end

a = (-1).^(0:w-1);

for i = 1: h
%     x = img(i,:);
    x = i1(i,:);
    if center == 1
        x = x.*a;
    end
    X = zeros(size(x));
    X = p2aFFT(x);
    f1(i,:) = X;
    if s == 3
    y = i2(i,:);
    if center == 1
        y = y.*a;
    end
    Y = zeros(size(y));
    Y = p2aFFT(y);
    f2(i,:) = Y;
    z = i3(i,:);
    if center == 1
        z = z.*a;
    end
    Z = zeros(size(z));
    Z = p2aFFT(z);
    f3(i,:) = Z;
    end
end

F1 = zeros(size(i1));
if s == 3
F2 = zeros(size(i2));
F3 = zeros(size(i3));
end

b = (-1).^(0:h-1);
b = transpose(b);

for i = 1:w
    x = f1(:,i);
    if center == 1
        x = x.*b;
    end
    X = zeros(size(x));
    X = p2aFFT(x);
    F1(:,i) = X;
    if s == 3
    y = f2(:,i);
    if center == 1
        y = y.*b;
    end
    Y = zeros(size(y));
    Y = p2aFFT(y);
    F2(:,i) = Y;
    z = f3(:,i);
    if center == 1
        z = z.*b;
    end
    Z = zeros(size(z));
    Z = p2aFFT(z);
    F3(:,i) = Z;
    end
end

figure, imshow(uint8(img1)); title('Original');
F(:,:,1) = F1;
if s == 3
F(:,:,2) = F2;
F(:,:,3) = F3;
end

figure, imshow(uint8(F)); title('FFT');

if center == 1
    im1 = ifft2(ifftshift(F1));
    if s == 3
    im2 = ifft2(ifftshift(F2));
    im3 = ifft2(ifftshift(F3));
    end
else
    im1 = ifft2(F1);
    if s == 3
    im2 = ifft2(F2);
    im3 = ifft2(F3);
    end
end

im(:,:,1) = im1;
if s == 3
im(:,:,2) = im2;
im(:,:,3) = im3;
end

% minVal = min(im(:));
% im(:,:,:) = im(:,:,:) - minVal;
% maxVal = max(im(:));
% im(:,:,:) = im(:,:,:)*255/maxVal;

I = im(j:h-j,k:w-k,:);
figure, imshow(uint8(I)); title('ifft of FFT');