function wiener = wiener (blured,psf,K)
    [M,N,depth] = size(blured);

    image = im2double(blured);
    H = fft2(psf,M,N);

    hasil = zeros(size(blured));

    for i = 1: depth
        channel = image(:,:,i);
        G = fft2(channel);

        wienerchannel = (1./H) .* (conj(H)./(conj(H) + K));
        
        hasilchanel = G .* wienerchannel;

        restore_chanel = ifft2(hasilchanel);

        hasil(:,:,i) = abs(restore_chanel);
       
    end
    wiener = hasil;
end