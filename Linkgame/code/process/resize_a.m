function mtx=resize_a(mtx0,height,width)
    [m,n,~]=size(mtx0);
    mtx=zeros(height,width,3);
    for i=1:3
        mtx_t=resample(mtx0(:,:,i),height,m);%横向插值
        mtx_t=resample(mtx_t.',width,n);%纵向插值
        mtx_t=mtx_t.';
        mtx(:,:,i)=mtx_t;
    end
end