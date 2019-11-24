function res = ftfunc1(l)
    res = zeros(size(l));
    res(l > 0) = 2 * pi * (2 - i) * exp(- l(l > 0) * (2 * i + 1));
    res(l < 0) = 2 * pi * (2 + i) * exp(- l(l < 0) * (2 * i - 1));
    res(l == 0) = NaN;
end
