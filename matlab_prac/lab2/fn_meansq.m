function res = fn_meansq(n, x)
    N = numel(x);
    nparts = 2 ^ floor(log(n) / log(2));
    curpart = n - nparts;
    res = zeros(size(x));
    from = fix(curpart / nparts * N) + 1;
    to = fix((curpart + 1) / nparts * N);
    res(from:to) = 1;
end
