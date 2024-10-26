function wiener = wiener (blured,psf,K)
    [M,N,depth] = size(blured);

    image = im2double(blured);
    H = fft2(psf,M,N);

    abskuadrath = conj(H) .* H;
    wienerfilter = (1./H) .* (abskuadrath./(abskuadrath + K));

    hasil = zeros(size(blured));

    for i = 1: depth
        channel = image(:,:,i);
        G = fft2(channel);
        
        hasilchanel = G .* wienerfilter;

        restore_chanel = ifft2(hasilchanel);

        hasil(:,:,i) = abs(restore_chanel);
       
    end
    wiener = hasil;
end