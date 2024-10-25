function filtered_image = periodic_car()
    image = imread('car_periodic.png');
    [M,N,~] = size(image);

    figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum');

    colsToMod = [39,63,87,115,137,138,139,163,238,239,240];

    for i = 1:length(colsToMod)
        F(:, colsToMod(i)) = 0;
        F(:, N - colsToMod(i) + 2) = 0;
    end

    rowsToMod = [24,25,26,92,93,94,156,157,158];

    for i = 1:length(rowsToMod)
        F(rowsToMod(i),:) = 0;
        F(M-rowsToMod(i) + 2, :) = 0;
    end
    S2 = log(1+abs(F));

    figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
    figure; imshow(G);title('Output image');
    filtered_image = abs(F(173:175,:));
end