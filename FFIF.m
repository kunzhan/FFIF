function F = FFIF(I,R,lambda)
    funNormalize = @(x) ( x-min(min(x)))/( max(max(x))-min(min(x)) + 1e-6);
    [hei, wid, imgn] = size(I);
    S = I.*0;
    N = boxfilter(ones(hei, wid), R); 
    for idx = 1:imgn    
        dIcdx = diff(I(:,:,idx), 1, 2);
        dIcdX = [dIcdx dIcdx(:,end)];
        dIcdy = diff(I(:,:,idx), 1, 1);
        dIcdY = [dIcdy;dIcdy(end,:)];
        g = abs(dIcdX) + abs(dIcdY);
        g = funNormalize(g);
        g = boxfilter(g, R) ./ N;
        S(:,:,idx) = 1 -  boxfilter(1-g, R) ./ N;
    end
    x = double(S(:,:,1) > S(:,:,2));
    W = boxfilter(x, R) ./ N;
    mu_w = boxfilter(W, R) ./ N;
    sigma_w = boxfilter(W.*W, R) ./ N;
    var_I = sigma_w - mu_w .* mu_w;
    k = var_I ./ (var_I + lambda); 
    W = mu_w + k.*(W - mu_w);
    F = I(:,:,1).*W + I(:,:,2).*(1-W);
end