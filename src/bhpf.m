function bhpf = bhpf(image)
    f = image;
    imshow(f);
    [M, N, depth] = size(f);
    if depth == 3
        f = rgb2gray(f);
    end
    f = im2double(f);
    
    % Step 1: Tentukan parameter padding
    P = 2 * M;
    Q = 2 * N;
    
    % Step 2: Bentuk citra padding
    fp = zeros(P, Q); % Inisialisasi citra padding
    fp(1:M, 1:N) = f; % Menyalin citra asli ke bagian atas kiri dari citra padded
    imshow(fp); title('padded image');
    
    % Step 3: Lakukan transformasi Fourier pada fp(x, y)
    F = fftshift(fft2(fp)); % Transformasi Fourier
    S2 = log(1 + abs(F)); % Spektrum Fourier
    figure, imshow(S2, []); title('Fourier spectrum');
    
    % Step 4: Bangkitkan fungsi penapis H untuk Butterworth Highpass Filter
    D0 = 50; % cut-off frequency
    n = 2;   % order of the filter
    
    % Set up range of variables
    u = 0:(P-1);
    v = 0:(Q-1);
    
    % Compute indices for use in meshgrid
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;
    
    % Compute meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);
    
    % Butterworth Highpass Filter
    H = 1 ./ (1 + (D0 ./ D).^(2*n)); % Fungsi Butterworth
    H(D == 0) = 0; % Menangani kasus D = 0
    H = fftshift(H); % Pindahkan pusat ke frekuensi
    
    figure; imshow(H); title('BHPF Butterworth Mask');
    figure, mesh(H);
    
    % Step 5: Kalikan F dengan H
    G = H .* F;
    G1 = ifftshift(G);
    
    % Step 6: Ambil bagian real dari inverse FFT of G
    G2 = real(ifft2(G1)); % Aplikasi inverse DFT
    
    % Step 7: Potong bagian kiri atas sehingga menjadi berukuran citra semula
    bhpf = G2(1:M, 1:N); % Resize the image untuk menghapus padding
    
    % Tampilkan citra output
    figure; imshow(bhpf); title('Output image after inverse 2D DFT');
end