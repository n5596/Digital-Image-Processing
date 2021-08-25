clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\football.jpg');
n = 4;
factor = 2;
im = img;

for i = 1:n
    [h,w,s] = size(im);
    newh = factor*h;
    neww = factor*w;
    I = zeros(newh,neww,s);
    for j = 1:h
        for k = 1:w
            I((j-1)*factor+1,(k-1)*factor+1,:) = im(j,k,:);
        end
    end
    
    for j = 2:2:newh
        for k = 1:neww
            if j == newh || j == newh-1
                I(j,k,:) = I(j-1,k,:);
            else
                I(j,k,:) = round(0.5*I(j-1,k,:) + 0.5*I(j+1,k,:));
            end
        end
    end
    for j = 1:newh
        for k = 2:2:neww
            if k == neww || k== neww-1
                I(j,k,:) = I(j,k-1,:);
            else
                I(j,k,:) = round(0.5*I(j,k-1,:) + 0.5*I(j,k+1,:));
            end
        end
    end
    figure, imshow(uint8(I)); title('Bilinear');
    disp(size(I));
    im = I;
end
            
                
                