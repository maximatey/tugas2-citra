function filtered_image = periodic_castle()
    image = imread('castle_periodic.jpeg');
    [M,N,~] = size(image);

%     figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

%     figure, imshow(S2,[]); title ('Fourier Spectrum');
   
    F(:,31) = 0;
    F(:,231) = 0;
    F(123,131) = 0;
    F(73,131) = 0;
    F(147,131) = 0;
    F(148,131) = 0;
    F(149,131) = 0;
    F(47,131) = 0;
    F(48,131) = 0;
    F(49,131) = 0;

    S2 = log(1+abs(F));

%     figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
%     figure; imshow(G);title('Output image');
    filtered_image = G;
end