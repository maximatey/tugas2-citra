function noise = noise_snp(image)
    noise = imnoise(image, "salt & pepper",0.02);
end