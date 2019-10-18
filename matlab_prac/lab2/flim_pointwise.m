function res = flim_pointwise(x)
    res = zeros(size(x));
    res(x == 1) = 1;
end
