function [val, point] = rhoSquare(l)
    val = abs(l(1, :)) + abs(l(2, :));
    point = zeros(size(l));
    for i = 1:size(l, 2)
        if abs(l(2, i)) < abs(l(1, i))
            point(:, i) = sign(l(1, i)) * [1; l(2, i) / l(1, i)];
        else 
            point(:, i) = sign(l(2, i)) * [l(1, i) / l(2, i); 1];
        end
    end
end
