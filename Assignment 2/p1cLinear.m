clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\onion.png');
n = 1;
factor = 2;
im1 = img;
im2 = img;

figure, imshow(uint8(im1)); title('Original');
for i = 1:n
    [h1,w1,s1] = size(im1);
    newh = factor*h1;
    Iy = zeros(newh,w1,s1);
    for j = 1:h1
        for k = 1:w1
            Iy((j-1)*factor+1,k,:) = im1(j,k,:);
        end
    end

    for j = 2:2:newh
        for k = 1:w1
            if j == newh || j == newh-1
                Iy(j,k,:) = Iy(j-1,k,:);
            else
                Iy(j,k,:) = round(0.5*Iy(j-1,k,:)+0.5*Iy(j+1,k,:));
            end
        end
    end
%     Ibar = zeros(newh,neww,s);
%     for j = 1:newh
%         for k = 1:w
%             Ibar(j,(k-1)*factor+1,:) = I(j,k,:);
%         end
%     end
%     for j = 1:newh
%         for k = 2:2:neww
%             if k == neww || k== neww-1
%                 Ibar(j,k,:) = Ibar(j,k-1,:);
%             else
%                 Ibar(j,k,:) = round(0.5*Ibar(j,k-1,:) + 0.5*Ibar(j,k+1,:));
%             end
%         end
%     end
%     figure, imshow(uint8(Ibar));
%     disp(size(Ibar));

    [h2, w2, s2] = size(im2);
    neww = factor*w2;
    Ix = zeros(h2,neww,s2);
    for j = 1:h2
        for k = 1:w2
            Ix(j,(k-1)*factor+1,:) = im2(j,k,:);
        end
    end

    for j = 1:h2
        for k = 2:2:neww
            if k == neww || k == newh-1
                Ix(j,k,:) = Ix(j,k-1,:);
            else
                Ix(j,k,:) = round(0.5*Ix(j,k-1,:)+0.5*Ix(j,k+1,:));
            end
        end
    end
    figure, imshow(uint8(Iy)); title('Iy');
    figure, imshow(uint8(Ix)); title('Ix');
    im1 = Iy;
    im2 = Ix;
end