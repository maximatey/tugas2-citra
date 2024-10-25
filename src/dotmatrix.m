function dotmatrix = dotmatrix(image,kernel,i,j,resultimagekonv)
    [row,col] = size(kernel);
    [rowimg,colimg,depth] = size(image);
    dividecol = floor(col/2);
    dividerow = floor(row/2);
    startrow = i-dividerow;
    startcol = j-dividecol;
    for d = 1:depth
        result = 0;
        itrrow = startrow;
        for r = 1:row
            itrcol = startcol;
            for c = 1:col
                multiply = image(itrrow,itrcol,d) * kernel(r,c);
                result = result + multiply;
                itrcol = itrcol + 1;
            end
            itrrow = itrrow + 1;
        end
        resultimagekonv(i,j,d) = result;
    end
    dotmatrix = resultimagekonv;
end

