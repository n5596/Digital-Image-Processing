clc;
close all;
clear all;

img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\toysnoflash.png');
F3 = fftshift(fft2(img));
[h, w, s] = size(img);

%-----IDEAL LOW PASS FILTER--------
ilpf = zeros(size(F3));
D0 = 30;
x = round(h/2);
y = round(w/2);
ilpf(x-D0/2:x+D0/2,y-D0/2:y+D0/2,:) = 1;
F4a = ilpf.*F3;
img4a = ifft2(ifftshift(F4a));

% figure, imshow(F4a);
figure, imshow(img); title('Original');
figure, imshow(uint8(img4a)); title('Ideal LPF');

%-----BUTTERWORTH LOW PASS FILTER------
blpf = zeros(size(F3));
n1 = 15;
for i = 1:h
    for j = 1:w
        Duv = sqrt((i-x).^2 + (j-y).^2);
        blpf(i,j,:) = 1/(1+((Duv/D0).^(2*n1)));
    end
end
F4b = blpf.*F3;
img4b = ifft2(ifftshift(F4b));

% figure, imshow(F4b);
figure, imshow(uint8(img4b)); title('Butterworth LPF');

%-------GAUSSIAN LOW PASS FILTER-------
glpf = zeros(size(F3));
sigma = 20;
for i = 1:h
    for j = 1:w
        Duv = sqrt((i-x).^2+(j-y).^2);
        glpf(i,j,:) = exp(-Duv*Duv/(2*sigma*sigma));
    end
end
F4c = glpf.*F3;
img4c = ifft2(ifftshift(F4c));

% figure, imshow(F4c);
figure, imshow(uint8(img4c)); title('Gaussian LPF');

%--------IDEAL HIGH PASS FILTER-------
ihpf = ones(size(F3));
ihpf(x-D0/2:x+D0/2,y-D0/2:y+D0/2,:) = 0;
F4d = ihpf.*F3;
img4d = ifft2(ifftshift(F4d));

% figure, imshow(F4d);
% figure, imshow(img); title('Original');
figure, imshow(uint8(img4d)); title('Ideal HPF');

%-------BUTTERWORTH HIGH PASS FILTER----
bhpf = ones(size(F3));
n2 = 6;
for i = 1:h
    for j= 1:w
        Duv = sqrt((i-x).^2 + (j-y).^2);
        bhpf(i,j,:) = 1/(1+((D0/Duv).^(2*n2)));
    end
end
F4e = bhpf.*F3;
img4e = ifft2(ifftshift(F4e));

% figure, imshow(F4e);
figure, imshow(uint8(img4e)); title('Butterworth HPF');

%-------GAUSSIAN HIGH PASS FILTER-----
ghpf = ones(size(F3));
ghpf = ghpf - glpf;
F4f = ghpf.*F3;
img4f = ifft2(ifftshift(F4f));

% figure, imshow(F4f);
figure, imshow(img4f); title('Gaussian HPF');