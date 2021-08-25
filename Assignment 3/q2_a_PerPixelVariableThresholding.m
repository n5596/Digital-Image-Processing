clc;
close all;
clear all;

img1 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign3_imgs\Cricket1.jpeg');
[h, w, s] = size(img1);
img1 = rgb2gray(img1);
img1 = double(img1);
mg = mean(img1(:));
ksize = 3; %kernel size
a = 0.009; %first 2 images
b = 1.3;

% a = 1; %third image
% b = 0.5;
 
% a = 0.05; %fifth
% b = 0.9;

for i = 1:h-ksize
    for j = 1:w-ksize
        patch = img1(i:i+ksize-1,j:j+ksize-1,:);
        mxy = mean(patch(:));
        sxy = var(patch(:));
        txy1(j) = a*sxy + b*mxy;
        txy2(j) = a*sxy + b*mg;
        if txy1(j) > 255 && j ~= 1
            txy1(j) = txy1(j-1);
        end
        if txy2(j) > 255 && j ~= 1
            txy2(j) = txy2(j-1);
        end
        
        for k = 1:ksize
            for l = 1:ksize
                if patch(k,l) > txy1(j)
                    out1(i+1,j+1) = 1;
                else
                    out1(i+1,j+1) = 0;
                end
                if patch(k,l) > txy2(j)
                    out2(i+1,j+1) = 1;
                else
                    out2(i+1,j+1) = 0;
                end
            end
        end
    end
end
% out1 = 1-(out1); %fifth
% out2 = 1-(out2);

figure, imshow((out1)); title('Per Pixel 1');
figure, imshow((out2)); title('Per Pixel 2');
        