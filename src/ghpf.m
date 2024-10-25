function ghpf = ghpf(image,DInput)
    f = image;
    [M, N, depth] = size(f);
    f = im2double(f);
    %Step 1: Tentukan parameter padding, biasanya untuk citra f(x,y)
    % berukuran M x N, parameter padding P dan Q biasanya P = 2M and Q = 2N.
    P = 2*M;
    Q = 2*N;
    %Step 2: Bentuklah citra padding fp(x,y) berukuran P X Q dengan
    % menambahkan pixel-pixel bernilai nol pada f(x, y).
    f = im2double(f);
    for d = 1: depth
        for i = 1:P
         for j = 1:Q
             if i <= M && j<= N
                 fp(i,j,d) = f(i,j,d);
             else
                 fp(i,j,d) = 0;
             end
         end
        end
    end
    matrixresult = fp;
    for i = 1: depth
        %Step 3: Lakukan transformasi Fourier pada fp(x, y) dan tampilkan Fourier Spectrum
        F = fftshift(fft2(fp(:,:,i))); % move the origin of the transform to the center of the frequency rectangle
        %Step 4: Bangkitkan fungsi penapis H berukuran P x Q, misalkan penapis
        %yang digunakan adalah Ideal Lowpass Filter (ILPF)
    
        D0 = DInput; % cut-off frequency
    
        % Set up range of variables.
        u = 0:(P-1);
        v = 0:(Q-1);
        % Compute the indices for use in meshgrid
        idx = find(u > P/2);
        u(idx) = u(idx) - P;
        idy = find(v > Q/2);
        v(idy) = v(idy) - Q;
        % Compute the meshgrid arrays
        [V, U] = meshgrid(v, u);
        D = sqrt(U.^2 + V.^2);
        H = exp(-(D.^2)./(2*(D0^2)));
        H = 1 - H;
        H = fftshift(H); 
        %Step 5: Kalikan F dengan H
        G = H.*F;
        G1 = ifftshift(G);
        %Step 6: Ambil bagian real dari inverse FFT of G:
        matrixresult(:,:,i) = real(ifft2(G1)); % apply the inverse, discrete Fourier transform
        
    end
    %Step 7: Potong bagian kiri atas sehingga menjadi berukuran citra semula
    ghpf = matrixresult(1:M, 1:N,:); % Resize the image to undo padding
end