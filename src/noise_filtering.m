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
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth); 

    for k = 1:3
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the midpoint
                minValue = min(localRegion(:));
                filteredImg(i, j, k) = minValue;
            end
        end
    end
    filtered_image = filteredImg/255;
end

function filtered_image = max_filter(image)
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth); 

    for k = 1:3
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the midpoint
                maxValue = max(localRegion(:));
                filteredImg(i, j, k) =  maxValue;
            end
        end
    end
    filtered_image = filteredImg/255;
end

function filtered_image = median_filter(image)
    [rows,cols,depth] = size(image);

    img = double(image);
    filteredImg = zeros(rows,cols,depth); 
    for k = 1:depth
        filteredImg(:,:,k) = ordfilt2(img(:,:,k), 5, ones(3)); % Median filter
    end
    filtered_image = filteredImg/255;
end

function filtered_image = arithmetic_mean_filter(image)
    kernel = ones(3,3) / 9; % 3x3 averaging kernel
    filtered_image = imfilter(image, kernel);
end

function filtered_image = geometric_mean_filter(image)
    [row,col,depth] = size(image);
    windowSize = 3;
    halfws = floor(windowSize/2);

    p = zeros(row,col,depth);
    for k = 1:depth
        for i = 1:row
            for j = 1:col
                % Define the region of interest
                rowStart = max(1, i - halfws);
                rowEnd = min(row, i + halfws);
                colStart = max(1, j - halfws);
                colEnd = min(col, j + halfws);
                
                % Extract the local neighborhood
                localRegion = image(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the product of the local neighborhood
                product = prod(localRegion, "all");
                
                % Calculate the geometric mean
                p(i, j, k) = product^(1 / (windowSize^2));
            end
        end
    end
    filtered_image = p/255;
end

function filtered_image = harmonic_mean_filter(image)
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth);
    for k = 1:depth
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the harmonic mean
                % Avoid division by zero by adding a small constant (e.g., 1e-10)
                nonZeroRegion = localRegion(localRegion > 0); % Filter out zeros
                if ~isempty(nonZeroRegion)
                    N = numel(nonZeroRegion);
                    harmonicMean = N / sum(1 ./ (nonZeroRegion + 1e-10)); % Adding a small constant to avoid division by zero
                    filteredImg(i, j, k) = harmonicMean;
                else
                    filteredImg(i, j, k) = 0; % If all values are zero, set the output to zero
                end
            end
        end
    end
    filtered_image = filteredImg/255;
end

function filtered_image = contraharmonic_mean_filter(image, Q)
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth);    
    for k = 1:depth
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the contraharmonic mean
                numerator = sum(localRegion(:).^(Q + 1));
                denominator = sum(localRegion(:).^Q);
                
                if denominator ~= 0
                    filteredImg(i, j, k) = numerator / denominator;
                else
                    filteredImg(i, j, k) = 0; % Set to 0 if the denominator is zero
                end
            end
        end
    end
    filtered_image = filteredImg/255;
end

function filtered_image = midpoint_filter(image)
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth); 

    for k = 1:depth
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Calculate the midpoint
                minValue = min(localRegion(:));
                maxValue = max(localRegion(:));
                filteredImg(i, j, k) = (minValue + maxValue) / 2;
            end
        end
    end
    filtered_image = filteredImg/255;
end

function filtered_image = alpha_trimmed_mean_filter(image, trim_factor)
    [rows,cols,depth] = size(image);
    windowSize = 3;
    halfWindow = floor(windowSize/2);

    img = double(image);
    filteredImg = zeros(rows,cols,depth); 

    for k = 1:depth
        for i = 1:rows
            for j = 1:cols
                % Define the region of interest
                rowStart = max(1, i - halfWindow);
                rowEnd = min(rows, i + halfWindow);
                colStart = max(1, j - halfWindow);
                colEnd = min(cols, j + halfWindow);
                
                % Extract the local neighborhood
                localRegion = img(rowStart:rowEnd, colStart:colEnd, k);
                
                % Sort the local neighborhood
                sortedRegion = sort(localRegion(:));
                
                % Trim the specified number of pixels
                numPixels = numel(sortedRegion);
                trimmedRegion = sortedRegion(trim_factor + 1 : numPixels - trim_factor);
                
                % Calculate the mean of the remaining pixels
                if ~isempty(trimmedRegion)
                    filteredImg(i, j, k) = mean(trimmedRegion);
                else
                    filteredImg(i, j, k) = 0; % Set to 0 if no pixels remain after trimming
                end
            end
        end
    end
    filtered_image = filteredImg/255;
end