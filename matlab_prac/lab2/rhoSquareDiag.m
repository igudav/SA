function [val, point] = rhoSquareDiag(x)
    val = abs(x(1, :) + x(2, :)) + abs(x(1, :) - x(2, :));
    point = 2 * x ./ (abs(x(1, :)) + abs(x(2, :)));
end
