function gaussfilter = gaussfilter(image,n,sigma)
    kernel = fspecial('gaussian', n, sigma);
    gaussfilter = konvolusi(image,kernel);
end