function konvolusi = konvolusi(image,kernel)
    [rowimg,colimg,depth] = size(image);
    [rowker,colker] = size(kernel);
    padrow = floor(rowker/2);
    padcol = floor(colker/2);
    paddingimage = padarray(image,[padrow,padcol],0,'both');
    [rowpadimg,colpadimg,depthpadimg] = size(paddingimage);
    for r=1+padrow: rowpadimg-padrow
        for c=1+padcol: colpadimg-padcol
            paddingimage = dotmatrix(paddingimage,kernel,r,c);
        end
    end
    konvolusi = paddingimage;
end