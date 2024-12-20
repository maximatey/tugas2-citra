function ilpf = ilpf(image,Dinput)
    f = image;
    [M, N, depth] = size(f);
    f = im2double(f);
    
    % Step 1: Tentukan parameter padding
    P = 2 * M;
    Q = 2 * N;
    
    % Step 2: Bentuk citra padding
    fp = zeros(P, Q, depth); % Inisialisasi citra padding
    fp(1:M, 1:N,1:depth) = f; % Menyalin citra asli ke bagian atas kiri dari citra padded
    matrixresult = fp;
    % Step 3: Lakukan transformasi Fourier pada fp(x, y)
    for i=1:depth
        F = fftshift(fft2(fp(:,:,i))); % Transformasi Fourier
        
        % Step 4: Bangkitkan fungsi penapis H untuk Ideal Lowpass Filter
        D0 = Dinput; % cut-off frequency
    
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
        
        % Ideal Lowpass Filter
        H = double(D <= D0); % Membuat filter ideal (1 untuk frekuensi kurang dari sama dengan D0, 0 untuk lainnya)
        H = fftshift(H); % Pindahkan pusat ke frekuensi
        
        
        % Step 5: Kalikan F dengan H
        G = H .* F;
        G1 = ifftshift(G);
        
        % Step 6: Ambil bagian real dari inverse FFT of G
        matrixresult(:,:,i) = real(ifft2(G1)); % Aplikasi inverse DFT
    end
    % Step 7: Potong bagian kiri atas sehingga menjadi berukuran citra semula
    ilpf = matrixresult(1:M, 1:N,:); % Resize the image untuk menghapus padding
end