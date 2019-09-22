function s = rectangles(x, y)
    % left rectangles
    y = y(1:end - 1);
    dx = diff(x);
    s = sum(dx .* y);
end
