[test1,map] = imread('bocil.png');
test1 = ind2rgb(test1,map);
hasil = wiener_glpf(test1,20,0.01);
imshow(hasil)