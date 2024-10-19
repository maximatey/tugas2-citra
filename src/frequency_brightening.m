function bright_image = frequency_brightening(image)
    % Check if the image is RGB
    if size(image, 3) == 3
        % Initialize the output image
        bright_image = zeros(size(image));
        
        % Process each channel separately
        for channel = 1:3
            f = image(:, :, channel); % Extract the channel
            f = im2double(f); % Convert to double
            
            % Display original channel
            figure; imshow(f); title(['Original Channel ', num2str(channel)]);

            % Get the size of the channel
            [M, N] = size(f);
            
            % Pad the image
            P = 2 * M;
            Q = 2 * N;
            fp = zeros(P, Q);
            fp(1:M, 1:N) = f; % Copy original channel to the top-left corner

            % Fourier Transform
            F = fftshift(fft2(fp));
            S2 = log(1 + abs(F)); % Fourier Spectrum
            figure, imshow(S2, []); title(['Fourier Spectrum Channel ', num2str(channel)]);

            % Create Low Pass Filter (LPF)
            D0 = 200; % cut-off frequency
            u = 0:(P-1);
            v = 0:(Q-1);
            idx = find(u > P/2);
            u(idx) = u(idx) - P;
            idy = find(v > Q/2);
            v(idy) = v(idy) - Q;
            [V, U] = meshgrid(v, u);
            D = sqrt(U.^2 + V.^2);
            H = exp(-(D.^2) / (2 * (D0^2)));
            H = fftshift(H); 
            figure, mesh(H);

            % Apply the filter
            G = H .* F;
            
            % Inverse Fourier Transform
            G1 = ifftshift(G);
            G2 = real(ifft2(G1)); % Get the real part

            % Normalize brightness
            G2 = G2 - min(G2(:)); % Normalize to positive range
            G2 = G2 / max(G2(:)); % Scale to [0, 1]

            % Store the brightened channel
            bright_image(:, :, channel) = G2(1:M, 1:N);
        end
    else
        % If not RGB, process as grayscale (existing logic)
        f = im2double(image);
    
        % Menampilkan citra asli
        figure; imshow(f); title('Original Image');
    
        % Mendapatkan ukuran citra
        [M, N] = size(f);
        
        % Padding citra
        P = 2 * M;
        Q = 2 * N;
        fp = zeros(P, Q);
        fp(1:M, 1:N) = f; % Menyalin citra asli ke bagian kiri atas
    
        % Transformasi Fourier
        F = fftshift(fft2(fp));
        S2 = log(1 + abs(F)); % Spektrum Fourier
        figure, imshow(S2, []); title('Fourier Spectrum');
    
        % Membuat Low Pass Filter (LPF)
        D0 = 200; % cut-off frequency
    
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
        figure, mesh(H);
    
        % Mengaplikasikan filter
        G = H .* F;
        
        % Inverse Fourier Transform
        G1 = ifftshift(G);
        G2 = real(ifft2(G1)); % Mengambil bagian real
    
        % Mengatur kecerahan
        G2 = G2 - min(G2(:)); % Normalisasi ke rentang positif
        G2 = G2 / max(G2(:)); % Skala ke rentang 0-1
        
        % Menampilkan citra hasil
        bright_image = G2(1:M, 1:N); % Citra yang lebih terang
    end
    
    % Display the final brightened image
    figure; imshow(bright_image); title('Brightened RGB Image after Frequency Filtering');
end