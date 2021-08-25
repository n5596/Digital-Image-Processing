clc;
close all;
clear all;
 
img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign3_imgs\circle2.jpg');
factor = 1; %0.4
[h1, w1,s1] = size(img);
aratio = h1/w1;
% img1a = imresize(img, 0.4) %image 1
img1a = imresize(img, [200 round(w1*200/h1)]);
[h,w,s] = size(img1a);

ha = h;
wa = w;
sa = 200; %100,

acc1 = zeros(ha,wa,sa);
gsize = 5;
sigma = 5;
threshold1 = 160;

[x y]=meshgrid(round(-(gsize-1)/2):round((gsize-1)/2), round(-(gsize-1)/2):round((gsize-1)/2));
gauss = 1/(2*pi*sigma*sigma)*exp(-(x.^2 + y.^2) / (2*sigma*sigma));
gauss = gauss / sum(gauss(:));
img1a = imfilter(img1a, gauss);
laplacian = [0 -1 0;-1 4 -1;0 -1 0];
% img1b = imfilter(img1a, laplacian);

if s == 3
    img1c = rgb2gray(img1a);
else
    img1c = img1a;
end
img1b = edge(img1c,'Canny');
img1b = img1b*255;
circles1 = zeros(size(img1a));
circles2 = img1a;
r = 50;

% figure, imshow(uint8(img1b));
for i = 1:h
    for j = 1:w
        if img1b(i,j,:) == 255
            for r = 10:100
                for angle = 0:360
                    rad = angle*pi/180;
                    c1 = floor(i-r*cos(rad));
                    c2 = floor(j-r*sin(rad));
                    if c1 > 0  & c2>0 & c1<=ha & c2<=wa
                        acc1(c1,c2,r) = acc1(c1,c2,r)+1;
                    end
                end
            end
%             circles1(i,j,:) = 255;
        end
    end
end

count = 0;
for i = 1:ha
    for j = 1:wa
        for k = 1:sa
            if acc1(i,j,k) >= threshold1
%                 circles1 = insertMarker(circles1, [i j], 'Size', 10);
%                 circles1 = insertShape(circles1,'Circle',[i j r],'Color','white','LineWidth',2);
                count = count+1;
                for angle = 0:360
                    rad = angle*pi/180;
                    p1 = floor(i-k*cos(rad));
                    p2 = floor(j-k*sin(rad));
                    if p1 >0 & p2 >0 & p1 < ha && p2 < wa
                        circles1(p1,p2,:) = 255;
                    end
                end
            end
        end
    end
end

% disp(count);
figure, imshow(img); title('Original');
figure, imshow(uint8(circles1)); title('Circles');

for i = 1:h
    for j = 1:w
        if circles1(i,j,:) == 255
            circles2(i,j,:) = 255;
        end
    end
end
figure, imshow(uint8(circles2)); title('Circles Detected');