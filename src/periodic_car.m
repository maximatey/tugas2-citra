function filtered_image = periodic_car()
    image = imread('car_periodic.png');
    [M,N,~] = size(image);

    figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum');
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
    figure; imshow(G);title('Output image');
    filtered_image = abs(F(173:175,:));
end