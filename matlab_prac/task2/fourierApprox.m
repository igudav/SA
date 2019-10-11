function res = fourierApprox(f, a, b, n, meth)
    % t for 1, sin, cos
    % c for Chebyshov
    % l for legendre polynoms

    if meth == 't'
        fn = @(n, x) fn_fourier(n, x, a, b, f);
    elseif meth == 'c'
        fn = @(n, x) fn_cheb(n, x, a, b, f);
    elseif meth == 'l'
        fn = @(n, x) fn_legendre(n, x, a, b, f);
    end
    convergenceFunc(fn, f, a, b, n, 'm');
end

function res = fn_fourier(n, x, a, b, f)

    INT_N_GRID = 1000;

    ee = ones(size(x));
    g = @(z) f((z + pi * ones(size(z))) / (2 * pi) * (b - a) + a * ones(size(z)));
    t = linspace(-pi, pi, INT_N_GRID);
    if n == 0
        res = 0.5 / pi * trapz(t, g(t)) * ee;
    else
        fn_fourier_mem = memoize(@fn_fourier);
        an = 1 / pi * trapz(t, g(t) .* cos(pi * n * t / pi));
        bn = 1 / pi * trapz(t, g(t) .* sin(pi * n * t / pi));
        y = (x - a * ee) / (b - a) * 2 * pi - pi * ee;
        res = fn_fourier_mem(n - 1, x, a, b, f) + an * cos(n * y) + bn * sin(n * y);
    end
end

function res = fn_cheb(n, x, a, b, f)

    INT_N_GRID = 1000;
    
    ee = ones(size(x));
    g = @(z) f((z + ones(size(z))) / 2 * (b - a) + a * ones(size(z)));
    t = linspace(-0.998, 0.998, INT_N_GRID);

    if n == 0
        res = 1 / pi * ee * trapz(t, g(t) ./ sqrt(1 - t .^ 2));
    else
        fn_cheb_mem = memoize(@fn_cheb);
        an = 2 / pi * trapz(t, g(t) .* t_cheb(n, t) ./ sqrt(1 - t .^ 2));
        y = (x - a * ee) / (b - a) * 2 - ee;
        res = fn_cheb_mem(n - 1, x, a, b, f) + an * t_cheb(n, y);
    end
end

function res = fn_legendre(n, x, a, b, f)
    
    INT_N_GRID = 1000;

    ee = ones(size(x));
    g = @(z) f((z + ones(size(z))) / 2 * (b - a) + a * ones(size(z)));
    t = linspace(-1, 1, INT_N_GRID);

    if n == 0
        res = 0.5 * ee * trapz(t, g(t));
    else
        fn_legendre_mem = memoize(@fn_legendre);
        an = (2 * n + 1) / 2 * trapz(t, g(t) .* t_legendre(n, t));
        y = (x - a * ee) / (b - a) * 2 - ee;
        res = fn_legendre_mem(n - 1, x, a, b, f) + an * t_legendre(n, y);
    end
end

function res = t_legendre(n, x)
    if n == 0
        res = ones(size(x));
    elseif n == 1
        res = x;
    else 
        t_legendre_mem = memoize(@t_legendre);
        res = (2 * n - 1) / n * x .* t_legendre_mem(n - 1, x) -...
            (n - 1) / n * t_legendre_mem(n - 2, x);
    end
end

function res = t_cheb(n, x)
    if n == 0
        res = ones(size(x));
    elseif n == 1
        res = x;
    else
        t_cheb_mem = memoize(@t_cheb);
        res = 2 * x .* t_cheb_mem(n - 1, x) - t_cheb_mem(n - 2, x);
    end
end
