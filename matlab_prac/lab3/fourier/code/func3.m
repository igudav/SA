function res = func3(t)
    res = t .^ 3 .* exp(-2 * t .^ 2 - t);
end
