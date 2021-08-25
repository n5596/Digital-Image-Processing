clc;
close all;
clear all;

img1 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\image_blending_with_laplacian_pyramid\example1\im1.jpg');
img2 = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\image_blending_with_laplacian_pyramid\example1\im2.jpg');
mask = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\image_blending_with_laplacian_pyramid\example1\mask.jpg');
% img = rgb2gray(img);
levels = 3;
% gsize = 50;
% sigma = 20;
gsize = 10;
sigma = 10;
[x y]=meshgrid(round(-(gsize-1)/2):round((gsize-1)/2), round(-(gsize-1)/2):round((gsize-1)/2));
gauss = 1/(2*pi*sigma*sigma)*exp(-(x.^2 + y.^2) / (2*sigma*sigma));
gauss = gauss / sum(gauss(:));
im1a = double(img1);
im1b = double(img2);
mask = im2bw(mask);
maskbar = imcomplement(mask);

% maskbar = mask;
% mask = imcomplement(mask);
% disp(maskbar);

for i = 1:levels
%     im2a = imfilter(im1a, gauss);
    [h,w,s] = size(im1a);
    im2a = zeros(size(im1a));
    
    if s == 3
        im2a(:,:,1) = gaussian(im1a(:,:,1), gsize, gauss);
        im2a(:,:,2) = gaussian(im1a(:,:,2), gsize, gauss);
        im2a(:,:,3) = gaussian(im1a(:,:,3), gsize, gauss);
    elseif s == 1
        im2a = gaussian(im1a, gsize, gauss);
    end
    
    G1 = im1a;
    [h1, w1, s1] = size(im2a);
    I1 = zeros(round(h1/2),round(w1/2),s1);
    for j = 1:2:h1
        for k = 1:2:w1
            if s1 == 3
                I1(round(j/2),round(k/2),:) = im2a(j,k,:);
            else 
                I1(round(j/2),round(k/2)) = im2a(j,k);
            end
        end
    end
    disp(size(I1));
    [a,b,c] = size(im1a);
%     Ibar = imresize(I,2);
    Ibar1 = imresize(I1,[a b]);   
    LL = zeros(size(im1a));
    L = zeros(size(im1a));
   
    L1 = im1a-(Ibar1);
    
    LL(:,:,1) = maskbar.*L1(:,:,1);
    LL(:,:,2) = maskbar.*L1(:,:,2);
    LL(:,:,3) = maskbar.*L1(:,:,3);

%     figure, imshow(uint8(LL)); title('LL');
    im1a = I1;
    
%     im2b = imfilter(im1b, gauss);
    [h,w,s] = size(im1b);
    im2b = zeros(size(im1b));
    
   if s == 3
        im2b(:,:,1) = gaussian(im1b(:,:,1), gsize, gauss);
        im2b(:,:,2) = gaussian(im1b(:,:,2), gsize, gauss);
        im2b(:,:,3) = gaussian(im1b(:,:,3), gsize, gauss);
    elseif s == 1
        im2b = gaussian(im1b, gsize, gauss);
   end
    
    [h2, w2, s2] = size(im2b);
    G2 = im1b;
    I2 = zeros(round(h2/2),round(w2/2),s2);
    for j = 1:2:h2
        for k = 1:2:w2
            if s2 == 3
                I2(round(j/2),round(k/2),:) = im2b(j,k,:);
            else
                I2(round(j/2),round(k/2)) = im2b(j,k);
            end
        end
    end
    disp(size(I2));
    [a,b,c] = size(im1b);
%     Ibar = imresize(I,2);
    Ibar2 = imresize(I2,[a b]);  
    LR = zeros(size(im1b));
    
    L2 = im1b-(Ibar2);
    LR(:,:,1) = mask .* L2(:,:,1);
    LR(:,:,2) = mask .* L2(:,:,2);
    LR(:,:,3) = mask .* L2(:,:,3);
  
%     figure, imshow(uint8(LR)); title('LR');
    im1b = I2;

    L = LL + LR;
%     figure, imshow(uint8(L)); title('L');

     imwrite(uint8(L),['L',num2str(i, '%02d'),'.png']);
     
    imwrite(uint8(LR),['LR',num2str(i, '%02d'),'.png']);   
    imwrite(uint8(LL),['LL',num2str(i, '%02d'),'.png']);

%     LS = (1-G2).*LL + G2.*LR;
%     figure, imshow(uint8(LS)); title('Combined');

    imwrite(uint8(I1),['Ga',num2str(i, '%02d'),'.png']);
    imwrite(uint8(I2),['Gb',num2str(i, '%02d'),'.png']);

    M = zeros(round(h2/2),round(w2/2));
    mask = imfilter(mask, gauss);
    for j = 1:2:h1
        for k = 1:2:w1
            M(round(j/2),round(k/2),:) = mask(j,k,:);
        end
    end
    imwrite(mask,['mask',num2str(i, '%02d'),'.png']);

    mask = M;
    maskbar = imcomplement(mask);
end
A = imread(['Ga',num2str(levels, '%02d'),'.png']);
B = imread(['Gb',num2str(levels, '%02d'),'.png']);
A = double(A)/255;
B = double(B)/255;

% G(:,:,1) = maskbar.*im1a(:,:,1) + mask.*im1b(:,:,1); 
% G(:,:,2) = maskbar.*im1a(:,:,2) + mask.*im1b(:,:,2); 
% G(:,:,3) = maskbar.*im1a(:,:,3) + mask.*im1b(:,:,3);

% G = A.*im1a + B.*im1b; 

A = im1a;
B = im1b;
G(:,:,1) = maskbar.*A(:,:,1) + mask.*B(:,:,1); 
G(:,:,2) = maskbar.*A(:,:,2) + mask.*B(:,:,2); 
G(:,:,3) = maskbar.*A(:,:,3) + mask.*B(:,:,3);

figure, imshow(uint8(G)); title('Blended');

for i = levels:-1:1
%     LL = double(imread(['LL',num2str(i, '%02d'),'.png']));
%     LR = double(imread(['LR',num2str(i, '%02d'),'.png']));
%     mask = double(imread(['mask',num2str(i, '%02d'),'.png']));
%     a = zeros(size(LL));
%     mask = im2bw(mask);
%     maskbar = imcomplement(mask);
%     
%     a(:,:,1) = maskbar.*LL(:,:,1) + mask.*LR(:,:,1); 
%     a(:,:,2) = maskbar.*LL(:,:,2) + mask.*LR(:,:,2); 
%     a(:,:,3) = maskbar.*LL(:,:,3) + mask.*LR(:,:,3);
    a = imread(['L',num2str(i, '%02d'),'.png']);
    a = double(a);
    
    [h,w,s] = size(a);
    G = imresize(G, [h w]);
    G(:,:,:) = G(:,:,:) + a(:,:,:);
    figure, imshow(uint8(G)); title('Blended');
    imwrite(uint8(G),['G',num2str(i, '%02d'),'.png']);
end
