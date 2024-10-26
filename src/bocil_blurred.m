[gambar,map] = imread('bocil.png');
gambar = ind2rgb(gambar,map);
hasil = wiener_glpf(gambar,20,0.01);
imshow(hasil)