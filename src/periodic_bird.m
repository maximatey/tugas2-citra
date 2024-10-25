function filtered_image = periodic_bird()
    image = imread('bird_periodic.jpeg');
    [M,N,~] = size(image);

%     figure, imshow(image); title('Original Image');

    f = im2double(image(:,:,1));
    F = fft2(f);
    F = fftshift(F);
    S2 = log(1+abs(F));

%     figure, imshow(S2,[]); title ('Fourier Spectrum');
    % Set up range of variables.
    u = 0:(M-1);
    v = 0:(N-1);

    % Compute the indices for use in meshgrid
    idx = find(u > M/2);
    u(idx) = u(idx) - M;
    idy = find(v > N/2);
    v(idy) = v(idy) - N;

    % Compute the meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);

    D0 = 7;  % Center frequency
    W = 2;    % Width of the band
    n = 1; 
    H = 1./(1 + ((D*W)./(D.^2 - D0^2)).^(2*n));
    H = fftshift(H);
%     figure;imshow(H);title('Butterworth Bandreject Filter orde n = 1');
    
    G = H.* F;

    D0 = 16;  % Center frequency
    W = 2;    % Width of the band
    n = 1; 
    H = 1./(1 + ((D*W)./(D.^2 - D0^2)).^(2*n));
    H = fftshift(H);
%     figure;imshow(H);title('Butterworth Bandreject Filter orde n = 1');
    
    J = H.* G;

    J = real(ifft2(ifftshift(J)));
%     figure; imshow(J);title('Output image');
    filtered_image = J;
end