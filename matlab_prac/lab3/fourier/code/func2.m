function res = func2(t)
    res = zeros(size(t));
    idx = abs(t) <= 1;
    res(idx) = t(idx) .^ 2 + t(idx);
end
