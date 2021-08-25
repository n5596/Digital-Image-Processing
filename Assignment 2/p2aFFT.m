function F = p2aFFT(points)
    N = length(points);
   if N == 1
       F = points;
   else
       a = 1;
       b = 1;
       odd = zeros(floor(N/2),1);
       if mod(N,2) == 1
           even = zeros(size(odd)+1);
       else
           even = zeros(size(odd));
       end
       for l = 1 : N
           if mod(l,2) == 0
               odd(a) = points(l);
               a = a+1;
           else
               even(b) = points(l);
               b = b+1;
           end
       end
%        E = p2aFFT(odd);
%        O = p2aFFT(even);
        E = p2aFFT(even);
        O = p2aFFT(odd);

       for l = 1:N/2
           w(l) = exp(-2*pi*j*(l-1)/N);
       end
       O = O.*w;
       F = [E+O E-O];
end