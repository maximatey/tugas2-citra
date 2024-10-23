function filtered_image = periodic_bird2()
    image = imread('bird_periodic.jpeg');
    [M,N,~] = size(image);

    figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum');
   
    F(118,118) = 0;
    F(108,108) = 0;
    F(113,129) = 0;
    F(113,97) = 0;
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
    figure; imshow(G);title('Output image');
    filtered_image = G;
end