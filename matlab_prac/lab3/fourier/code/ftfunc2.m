function res = ftfunc2(l)
    re = (2 * (l .^ 2 - 2) .* sin(l) + 4 * l .* cos(l)) ./ l .^ 3;
    im = (2 * l .* cos(l) - 2 * sin(l)) ./ l .^ 2;
    re(isnan(re)) = 2 / 3;
    im(isnan(im)) = 0;
    res = re + i * im;
end
