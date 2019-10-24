function [val, point] = rhoCircle(l)
    val = 2 * (l(1, :) + l(2, :)) + 2 * (l(1, :) + l(2, :)) + (l(1, :) .^ 2 + l(2, :) .^ 2) .^ 0.5;
    point = 2 * ones(size(l)) + l ./ ((l(1, :) .^ 2 + l(2, :) .^ 2) .^ 0.5) + 2;
end
