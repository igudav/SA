function s = simpson(x, y)
    if mod(length(x), 2) ~= 1
        error('we need N = 2n deltas and 2n + 1 points for this method');
    end
    
    h = x(2) - x(1);
    s = y(1) + 2 * sum(y(3:2:end - 2)) + 4 * sum(y(2:2:end - 1)) + y(end);
    s = s * h / 3;
end
