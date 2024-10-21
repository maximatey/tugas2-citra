function meanfilter = meanfilter(image,n)
    kernel = ones(n, n)/(n *n);
    meanfilter = konvolusi(image,kernel);
end
