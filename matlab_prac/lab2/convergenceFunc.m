function res = convergenceFunc(fn, f, a, b, n, convType)
    % p for pointwise
    % u for uniform
    % m for meansqare
    
    mov(1:n) = struct('cdata', [], 'colormap', []);
    x = a:0.05:b;
    ee = ones(size(x));
    for k = 1:n
        yfn = fn(k, x);
        yf = f(x);
        if convType == 'p'
            ttl = '-';
            metr_name = '';
        elseif convType == 'u'
            ttl = num2str(max(abs(yf - yfn)));
            metr_name = '$\max \left\lvert f_n(x) - f(x) \right\rvert = $';
        else
            ttl = num2str(sqrt(trapz(x, (yfn - yf) .^ 2)));
            metr_name = '$\left( \int_{-1}^1(f_n(x) - f(x))^2 \,dx\right)^{1/2} = $';
        end
        plot(x, fn(k, x), x, f(x));
        legend('$f_n(x)$', '$f(x)$', 'interpreter', 'latex');
        title(strcat(metr_name, ttl), 'interpreter', 'latex');
        mov(k) = getframe();
    end
end
