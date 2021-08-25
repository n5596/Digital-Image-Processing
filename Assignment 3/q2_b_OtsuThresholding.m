clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign3_imgs\Cricket5.jpeg');
img2 = rgb2gray(img);
[h2,w2,s2] = size(img2);
c1 = zeros(h2*w2,2);
c2 = zeros(h2*w2,2);
c1max = c1;
c2max = c2;
hist2 = imhist(img2);
nhist2 = hist2/(h2*w2); %normalized histogram

maxvar = -1;
var = -1;
maxt = -1;
mg = sum(img2(:))/(h2*w2);

for t2 = 120:150
    a = 1;
    b = 1;
    for i = 1:h2
        for j = 1:w2
            if img2(i,j,:) <= t2
                c1(a,1:2) = [i j];
                a = a+1;
            else
                c2(b,1:2) = [i j];
                b = b+1;
            end
        end
    end

    g1size = size(c1);
    g2size = size(c2);

    s1 = 0;
    s2 = 0;
    for i = 1:a-1
        p1 = c1(i,:);
        val1 = double(img2(p1(1), p1(2),:));
        s1 = s1+val1;
    end
    for i = 1:b-1
        p2 = c2(i,:);
        val2 = double(img2(p2(1),p2(2),:));
        s2 = s2+val2;
    end

    m1 = s1/(a-1);
    m2 = s2/(b-1);
    p1 = (a-1)/(h2*w2);
    p2 = 1-p1;
    
    var = p1*(m1-mg).^2 + p2*(m2-mg).^2;
    if var > maxvar
        maxvar = var;
        maxt = t2;
        c1max = c1;
        c2max = c2;
    end
%     disp([var maxvar]);
end

seg2 = zeros(h2,w2);
whitepix = size(c1);
for i = 1: whitepix
    point = c2(i,:);
    if point(1) ~= 0 & point(2) ~=0
        seg2(point(1), point(2)) = 255;
    end
end
figure, imshow(img); title('Original');
figure, imshow(uint8(seg2)); title('Otsu');