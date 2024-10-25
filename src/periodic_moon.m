function filtered_image = periodic_moon()
    image = imread('moon_periodic.jpeg');
    [M,N,~] = size(image);

    figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum');
    cols_to_zero = [5, 6, 7, 19, 20, 21, 46, 47, 48, 56, 57, 58, 77, 78, 79, 253, 254, 255, 256, 249, 250, 251, 212, 213, 214, 202, 203, 204, 181, 182, 183];
    rows_to_zero = [27, 28, 29, 45, 46, 47, 150, 151, 152, 167, 168, 169, 96, 97, 98];
    for col = cols_to_zero
        for row = rows_to_zero
            F(row, col) = 0;
        end
    end

    for col = cols_to_zero
        F(:, col) = 0;  % Set entire column to zero
    end
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
    figure; imshow(G);title('Output image');
    filtered_image = G;
end