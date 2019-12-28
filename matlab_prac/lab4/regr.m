function res = regr(n, T, max_pow)
    W = [ones(numel(n), 1) cumprod(repmat(n', 1, max_pow), 2)];
    res = (W' * W) \ W' * T;
end
