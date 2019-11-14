function res = odefunc_task8(x, y)
    res = [y(2); -y(1) + 2 .* x - pi];
end
