clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\cameraman.tif');
n = 2;
factor = 2;
im = img;
% im = rgb2gray(im);

[h,w,s] = size(im);

Ainv = [
 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0;
 -3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0;
 2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0;
 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;
 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0;
 0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0;
 0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0;
 -3,0,3,0,0,0,0,0,-2,0,-1,0,0,0,0,0;
 0,0,0,0,-3,0,3,0,0,0,0,0,-2,0,-1,0;
 9,-9,-9,9,6,3,-6,-3,6,-6,3,-3,4,2,2,1;
 -6,6,6,-6,-3,-3,3,3,-4,4,-2,2,-2,-2,-1,-1;
 2,0,-2,0,0,0,0,0,1,0,1,0,0,0,0,0;
 0,0,0,0,2,0,-2,0,0,0,0,0,1,0,1,0;
 -6,6,6,-6,-4,-2,4,2,-3,3,-3,3,-2,-1,-2,-1;
 4,-4,-4,4,2,2,-2,-2,2,-2,2,-2,1,1,1,1
 ];

figure, imshow(img); title('Original');
im = double(im);

for i = 1:n
    [h,w,s] = size(im);
    newh = h*factor;
    neww = w*factor;
    I = zeros(newh,neww,s);
    
    fx = zeros(size(im));
    fy = zeros(size(im));
    fxy = zeros(size(im));
    fxydir = zeros(size(im));
    
    if s == 3
        [fx(:,:,1) fy(:,:,1)] = imgradientxy(im(:,:,1));
        [fx(:,:,2) fy(:,:,2)] = imgradientxy(im(:,:,2));
        [fx(:,:,3) fy(:,:,3)] = imgradientxy(im(:,:,3));
        [fxy(:,:,1), fxydir(:,:,1)] = imgradient(im(:,:,1));
        [fxy(:,:,2), fxydir(:,:,2)] = imgradient(im(:,:,2));
        [fxy(:,:,3), fxydir(:,:,3)] = imgradient(im(:,:,3));  
    elseif s == 1
        [fx,fy] = imgradientxy(im);
        [fxy,fxydir] = imgradient(im);
    end
        
    for j = 0:newh-1
        for k = 0:neww-1         
        t1 = 1+floor(j./factor);
        t2 = 1+floor(k./factor);
        t3 = 1+ceil(j./factor);
        t4 = 1+ceil(k./factor);
        
        x1 = [t1 t2];
        x2 = [t1 t4];
        x3 = [t3 t2];
        x4 = [t3 t4];
        
        d1 = -(((j./factor)-floor(j./factor))-1);
        d2 = -(((k./factor)-floor(k./factor))-1);
        
        if x3(1) > size(im,1)
            x3(1) = size(im,1);
            x4(1) = x3(1);
            
        end
        if x2(2) > size(im,2)
            x2(2) = size(im,2);
            x4(2) = x2(2);
        end
        
        f00 = im(x1(1),x1(2),:);
        f01 = im(x2(1),x2(2),:);
        f10 = im(x3(1),x3(2),:);
        f11 = im(x4(1),x4(2),:);
        
%         if x3(1) > size(fx,1)
%         x3(1) = size(fx,1);
%         x4(1) = x3(1);
%         end
%         if x2(2) > size(fx,2)
%             x2(2) = size(fx,2);
%             x4(2) = x2(2);
%         end
        
        fx00 = fx(x1(1),x1(2),:);
        fx01 = fx(x2(1),x2(2),:);
        fx10 = fx(x3(1),x3(2),:);
        fx11 = fx(x4(1),x4(2),:);
        
        if x3(1) > size(fy,1)
        x3(1) = size(fy,1);
        x4(1) = x3(1);
        end
        
        fy00 = fy(x1(1),x1(2),:);
        fy01 = fy(x2(1),x2(2),:);
        fy10 = fy(x3(1),x3(2),:);
        fy11 = fy(x4(1),x4(2),:);
        
        fxy00 = fxy(x1(1),x1(2),:);
        fxy01 = fxy(x2(1),x2(2),:);
        fxy10 = fxy(x3(1),x3(2),:);
        fxy11 = fxy(x4(1),x4(2),:);
        
        if s == 3
        xa = transpose([f00(:,:,1) f10(:,:,1) f01(:,:,1) f11(:,:,1) fx00(:,:,1) fx10(:,:,1) fx01(:,:,1) fx11(:,:,1) fy00(:,:,1) fy10(:,:,1) fy01(:,:,1) fy11(:,:,1) fxy00(:,:,1) fxy10(:,:,1) fxy01(:,:,1) fxy11(:,:,1)]);
        xa = double(xa);
        alpha1 = Ainv*xa;

        xb = transpose([f00(:,:,2) f10(:,:,2) f01(:,:,2) f11(:,:,2) fx00(:,:,2) fx10(:,:,2) fx01(:,:,2) fx11(:,:,2) fy00(:,:,2) fy10(:,:,2) fy01(:,:,2) fy11(:,:,2) fxy00(:,:,2) fxy10(:,:,2) fxy01(:,:,2) fxy11(:,:,2)]);
        xb = double(xb);
        alpha2 = Ainv*xb;
        
        xc = transpose([f00(:,:,3) f10(:,:,3) f01(:,:,3) f11(:,:,3) fx00(:,:,3) fx10(:,:,3) fx01(:,:,3) fx11(:,:,3) fy00(:,:,3) fy10(:,:,3) fy01(:,:,3) fy11(:,:,3) fxy00(:,:,3) fxy10(:,:,3) fxy01(:,:,3) fxy11(:,:,3)]);
        xc = double(xc);
        alpha3 = Ainv*xc;
        elseif s == 1
        x = transpose([f00 f10 f01 f11 fx00 fx10 fx01 fx11 fy00 fy10 fy01 fy11 fxy00 fxy10 fxy01 fxy11]);
        x = double(x);
        alpha = Ainv*x;
        end
        
        if s == 3
            patch1 = 0;
            patch2 = 0;
            patch3 = 0;
        elseif s == 1
            patch = 0;
        end
        
        for l = 1:16
            a1 = floor((l-1)/4);
            a2 = mod(l-1,4);
            if s == 3
                patch1 = patch1 + alpha1(l).*((1-d1)^(a1)).*((1-d2)^(a2));
                patch2 = patch2 + alpha2(l).*((1-d1)^(a1)).*((1-d2)^(a2));
                patch3 = patch3 + alpha3(l).*((1-d1)^(a1)).*((1-d2)^(a2));
            elseif s == 1
                patch = patch + alpha(l).*((1-d1)^(a1)).*((1-d2)^(a2));
            end
        end
%         disp(patch);
        if s == 3
            I(j+1,k+1,1) = patch1;
            I(j+1,k+1,2) = patch2;
            I(j+1,k+1,3) = patch3;
        elseif s == 1
            I(j+1,k+1) = patch;
        end

        end
    end       
    figure, imshow(uint8(I)); title('Bicubic');
    disp(size(I));
    im = I;
end