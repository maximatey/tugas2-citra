function filtered_image = noise_filtering(image, method, Q)
% method options:
% 0: min
% 1: max
% 2: median
% 3: arithmetic mean
% 4: geometric mean
% 5: harmonic mean
% 6: contraharmonic mean
% 7: midpoint
% 8: alpha trimmed mean

    if method == 0
       filtered_image = min_filter(image);
   elseif method == 1
        filtered_image = max_filter(image);
    elseif method == 2
        filtered_image = median_filter(image);
    elseif method == 3
        filtered_image = arithmetic_mean_filter(image);
    elseif method == 4
        filtered_image = geometric_mean_filter(image);
    elseif method == 5
        filtered_image = harmonic_mean_filter(image);
    elseif method == 6
        filtered_image = contraharmonic_mean_filter(image, Q);
    elseif method == 7
        filtered_image = midpoint_filter(image);
    elseif method == 8
        filtered_image = alpha_trimmed_mean_filter(image, Q);
   end
end






function filtered_image = min_filter(image)
    filtered_image = ordfilt2(image, 1, ones(3)); % Minimum filter
end

function filtered_image = max_filter(image)
    filtered_image = ordfilt2(image, 9, ones(3)); % Maximum filter
end

function filtered_image = median_filter(image)
    filtered_image = ordfilt2(image, 5, ones(3)); % Median filter
end

function filtered_image = arithmetic_mean_filter(image)
    kernel = ones(3,3) / 9; % 3x3 averaging kernel
    filtered_image = imfilter(image, kernel);
end

function filtered_image = geometric_mean_filter(image)
    filtered_image = image;
end

function filtered_image = harmonic_mean_filter(image)
    filtered_image = image;
end

function filtered_image = contraharmonic_mean_filter(image, Q)
    filtered_image = image;
end

function filtered_image = midpoint_filter(image)
    filtered_image = image;
end

function filtered_image = alpha_trimmed_mean_filter(image, trim_factor)
    filtered_image = image;
end