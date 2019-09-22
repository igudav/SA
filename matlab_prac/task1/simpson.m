function s = simpson(h, Y)
    if mod(length(Y), 2) ~= 1
        error('we need N = 2n + 1 points for this method');
    end
    
    s = Y(:, 1) + 2 * sum(Y(:, 3:2:end - 2), 2) + 4 * sum(Y(:, 2:2:end - 1), 2) + Y(:, end);
    s = s * h / 3;
end
