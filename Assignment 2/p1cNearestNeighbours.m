clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\cameraman.tif');
n = 3;
factor = 2;
im = img;

for i = 1:n
    [h,w,s] = size(im);
    newh = h*factor;
    neww = w*factor;
    I = zeros(newh,neww,s);
    for j = 1:newh
        for k = 1:neww
            l = round(((j-0.5)/factor)+0.5);
            m = round(((k-0.5)/factor)+0.5);
            I(j,k,:) = im(l,m,:);
        end
    end
    figure, imshow(uint8(I));
    disp(size(I));
    im = I;
end
