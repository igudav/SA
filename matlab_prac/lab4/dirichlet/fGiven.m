function res = fGiven(X, Y)
    res = X .* exp(-4 * X) + cos(X) + 2 * Y .* exp(2 * Y) .* sin(2 * Y);
end
