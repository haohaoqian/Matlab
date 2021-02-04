function mtx=resize(mtx0,height,width)
    [m,n]=size(mtx0);
    mtx=resample(mtx0,height,m);%横向插值
    mtx=resample(mtx.',width,n);%纵向插值
    mtx=mtx.';
end