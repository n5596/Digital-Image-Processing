clc;
close all;
clear all;

img1 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\notch_pass_reject_filter\notch1.png');
img2 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\notch_pass_reject_filter\notch2.jpg');
img3 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\notch_pass_reject_filter\notch3.jpg');

[h1,w1,s1] = size(img1);
[h2,w2,s2] = size(img2);
[h3,w3,s3] = size(img3);

if s1 == 3
    img1 = rgb2gray(img1);
end
if s2 == 3
    img2 = rgb2gray(img2);
end
if s3 == 3
    img3 = rgb2gray(img3);
end

threshold = 10;
F1 = fftshift(fft2(img1));
F2 = fftshift(fft2(img2));
F3 = fftshift(fft2(img3));

% figure, imshow(real(F1));
ampImg1 = log(abs(F1));
thresh1 = ampImg1 > threshold;
% figure, imshow(thresh1);
% thresh1(111:144,134:172,:) = 0;
thresh1(114:175,152:171,:) = 0;
% figure, imshow(thresh1);
notch1 = 1-thresh1;
T1 = notch1.*F1;
img1a = ifft2(ifftshift(T1));
img1a = real(img1a);
f1a = fftshift(fft2(img1));
f1b = fftshift(fft2(img1a));

figure, imshow(img1); title('Original');
figure, imshow(uint8(img1a)); title('Corrected');
figure, imshowpair(img1,uint8(img1a)); title('Difference');
figure, imshow(uint8(f1a)); title('Original FFT');
figure, imshow(uint8(f1b)); title('Corrected FFT');

ampImg2 = log(abs(F2));
thresh2 = ampImg2 > threshold;
% figure, imshow(thresh2);
thresh2(50:75,50:75,:) = 0; 
% thresh2(55:72,55:72,:) = 0; % figure,
% imshow(thresh2);
notch2 = 1-thresh2;
T2 = notch2.*F2;
img2a = ifft2(ifftshift(T2));
img2a = real(img2a);
f2a = fftshift(fft2(img2));
f2b = fftshift(fft2(img2a));

figure, imshow(img2); title('Original');
figure, imshow(uint8(img2a)); title('Corrected');
figure, imshowpair(img2,uint8(img2a)); title('Difference');
figure, imshow(uint8(f2a)); title('Original FFT');
figure, imshow(uint8(f2b)); title('Corrected FFT');

ampImg3 = log(abs(F3));
thresh3 = ampImg3 > threshold;
% figure, imshow(thresh3);
% thresh2(48:78,49:78,:) = 0;
thresh3(99:156,100:163,:) = 0;
% figure, imshow(thresh3);
notch3 = 1-thresh3;
T3 = notch3.*F3;
img3a = ifft2(ifftshift(T3));
img3a = real(img3a);

f3a = fftshift(fft2(img3)); 
f3b = fftshift(fft2(img3a));

figure, imshow(img3); title('Original');
figure, imshow(uint8(img3a)); title('Corrected');
figure, imshowpair(img3,uint8(img3a)); title('Difference');
figure, imshow(uint8(f3a));title('Original FFT');
figure, imshow(uint8(f3b)); title('Corrected FFT');