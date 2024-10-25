function filtered_image = periodic_robot()
    image = imread('robot_periodic.jpg');
    [M,N,~] = size(image);

    figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum');
    colsToMod = [63, 64, 69, 70, 122, 123, 134, 135, 136];
    
    for i = 1:length(colsToMod)
        F(:, colsToMod(i)) = 0;
        F(:, N - colsToMod(i) + 2) = 0;
    end

    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
    figure; imshow(G);title('Output image');
    filtered_image = G;
end