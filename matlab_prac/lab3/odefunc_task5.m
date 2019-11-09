% x1' = v1
% v1' = G * m1 * m2 * (x2 - x1) / norm(x2 - x1) ^ 3
% x2' = v2
% v2' = G * m1 * m2 * (x1 - x2) / norm(x2 - x1) ^ 3

function y = odefunc_task5(t, y, G, m1, m2)
    y = [y(3:4); G * m1 * m2 * (y(5:6) - y(1:2)) / norm(y(5:6) - y(1:2)) ^ 3;...
        y(7:8); G * m1 * m2 * (y(1:2) - y(5:6)) / norm(y(5:6) - y(1:2)) ^ 3];
end
