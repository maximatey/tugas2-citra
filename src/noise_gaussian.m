function noise = noise_gaussian(image)
    noise = imnoise(image, "gaussian",0, 0.02);
end