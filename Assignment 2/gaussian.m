function out = gaussian(img, size1,gauss1)
imgt1 = padarray(img, [floor(size1/2) floor(size1/2)]);
imgt1 = double(imgt1);
[h1, w1, s1] = size(imgt1);
out = zeros(size(img));
    for i = floor(size1/2):h1-floor(size1/2)-1
        for j = floor(size1/2):w1-floor(size1/2)-1
            I = imgt1(i-floor(size1/2)+1:i+floor(size1/2)+1,j-floor(size1/2)+1:j+floor(size1/2)+1);
            Ibar = I.*gauss1;
            out(i-floor(size1/2)+1,j-floor(size1/2)+1) = sum(Ibar(:))/sum(gauss1(:));
        end
    end
end