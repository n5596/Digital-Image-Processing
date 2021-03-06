clc;
close all;
clear all;

%-----DOING LINEAR INTERPOLATION OVER COLUMNS AND THEN ROWS------
img = imread('C:\Third Year Semester 1\Digital Image Processing\Assign2_imgs\other_images\onion.png');
n = 2;
factor = 2;
im = img;

for i = 1:n
    [h,w,s] = size(im);
    newh = factor*h;
    neww = factor*w;
    
    Ix = zeros(newh,w,s);
    Iy = zeros(h,neww,s);
    for j = 1:h
        for k = 1:w
            if s == 3
                Ix((j-1)*factor+1,k,:) = im(j,k,:);
                Iy(j,(k-1)*factor+1,:) = im(j,k,:);  
            elseif s == 1
               Ix((j-1)*factor+1,k) = im(j,k);
            Iy(j,(k-1)*factor+1) = im(j,k);  
            end
        end
    end
    a = Ix;
    b = Iy;
    for j = 2:2:newh
        for k = 1:w
            if j == newh || j == newh-1
                if s == 3
                Ix(j,k,:) = Ix(j-1,k,:);
                elseif s == 1
                    Ix(j,k) = Ix(j-1,k);
                end
            else
                if s == 3
                    Ix(j,k,:) = round(0.5*Ix(j-1,k,:)+0.5*Ix(j+1,k,:));
                elseif s == 1
                    Ix(j,k) = round(0.5*Ix(j-1,k)+0.5*Ix(j+1,k));
                end
            end
        end
    end
    Ixbar = zeros(newh,neww,s);
    for j = 1:newh
        for k = 1:w
            Ixbar(j,(k-1)*factor+1,:) = Ix(j,k,:);
        end
    end
    for j = 1:newh
        for k = 2:2:neww
            if k == neww || k== neww-1
                if s == 3
                    Ixbar(j,k,:) = Ixbar(j,k-1,:);
                elseif s == 1
                    Ixbar(j,k) = Ixbar(j,k-1);
                end
            else
                if s == 3
                    Ixbar(j,k,:) = round(0.5*Ixbar(j,k-1,:) + 0.5*Ixbar(j,k+1,:));
                elseif s == 1
                    Ixbar(j,k) = round(0.5*Ixbar(j,k-1) + 0.5*Ixbar(j,k+1));
                end
            end
        end
    end
    
    for j = 1:h
        for k = 2:2:neww
            if k == neww || k == neww-1
                if s == 3
                    Iy(j,k,:) = Iy(j,k-1,:);
                elseif s == 1
                    Iy(j,k) = Iy(j,k-1);
                end
            else
                if s == 3
                    Iy(j,k,:) = round(0.5*Iy(j,k-1,:)+0.5*Iy(j,k+1,:));
                elseif s == 1
                    Iy(j,k) = round(0.5*Iy(j,k-1)+0.5*Iy(j,k+1));
                end
            end
        end
    end
    Iybar = zeros(newh,neww,s);
    for j = 1:h
        for k = 1:neww
            if s == 3
                Iybar((j-1)*factor+1,k,:) = Iy(j,k,:);
            elseif s == 1
                Iybar((j-1)*factor+1,k) = Iy(j,k);
            end
        end
    end
    for j = 2:2:newh
        for k = 1:neww
            if j == newh || h== newh-1
                if s == 3
                    Iybar(j,k,:) = Iybar(j-1,k,:);
                elseif s == 1
                    Iybar(j,k) = Iybar(j-1,k);
                end
            else
                if s == 3
                    Iybar(j,k,:) = round(0.5*Iybar(j-1,k,:) + 0.5*Iybar(j+1,k,:));
                elseif s == 1
                    Iybar(j,k) = round(0.5*Iybar(j-1,k) + 0.5*Iybar(j+1,k));

                end
            end
        end
    end
    im = Ixbar;
    figure, imshow(uint8(Ixbar));
    disp([size(Ixbar) size(Iybar)]);
end