function [x, fval, steps] = min_coord(f, df, x0, eps)
    n = length(x0);
    steps = [x0; f(x0)];
    niter = 1;
    MAX_ITERS = 10000;
    while 1
        i = mod(niter, n) + 1;
        mask = ones(n, 1);
        mask(i) = 0;
        x0(i) = fzero(@(l) df(x0 .* mask + l .* (1 - mask), i), x0(i));
        steps = [steps [x0; f(x0)]];
        if niter >= MAX_ITERS
            error('iterations ceil reached');
        end
        if i == 1 &...
                norm(steps(1:end-1, end) - steps(1:end-1, end-1)) < eps
            disp(niter);
            x = x0;
            fval = steps(end, end);
            break;
        else 
            niter = niter + 1;
        end
    end
end
