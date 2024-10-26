function wiener_glpf = wiener_glpf (blured,D0,K)
    [N,M,depth] = size(blured);

    image = blured;

    u = 0:(N-1);
    v = 0:(M-1);
    idx = find(u > N/2); 
    u(idx) = u(idx) - N; 
    idy = find(v > M/2); 
    v(idy) = v(idy) - M;
    [V, U] = meshgrid(v, u); 
    D = sqrt(U.^2 + V.^2); 
    H = exp(-(D.^2)./(2*(D0^2)));
    H = fftshift(H);
    
    abskuadrath = conj(H) .* H;
    wienerfilter = (1./H) .* (abskuadrath./(abskuadrath + K));

    hasil = zeros(size(blured));

    for i = 1: depth
        channel = image(:,:,i);
        G = fftshift(fft2(channel));
        
        hasilchanel = G .* wienerfilter;
        
        hasilchanel = ifftshift(hasilchanel);
        restore_chanel = real(ifft2(hasilchanel));

        hasil(:,:,i) = abs(restore_chanel);
       
    end
    hasil = mat2gray(hasil);
    wiener_glpf = hasil;
end