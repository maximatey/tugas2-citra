function filtered_image = periodic_moon()
    image = imread('moon_periodic.tif');
    [M,N,~] = size(image);
 
%     figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

%     figure, imshow(S2,[]); title ('Fourier Spectrum');
    colsToMod = [14,40,61,66,87,92,113,118,139,165,191,212,217,238,243,264,269,290,295];
    
    for i = 1:length(colsToMod)
        F(:, colsToMod(i)) = 0;
        F(:, N - colsToMod(i) + 2) = 0;
    end

    rowsToMod = [14,61,108,118,134,165,181,191];

    for i = 1:length(rowsToMod)
        F(rowsToMod(i),:) = 0;
        F(M-rowsToMod(i) + 2, :) = 0;
    end
    S2 = log(1+abs(F));

%     figure, imshow(S2,[]); title ('Fourier Spectrum After');
    G = real(ifft2(ifftshift(F)));
%     figure; imshow(G);title('Output image');
    filtered_image = G;
end