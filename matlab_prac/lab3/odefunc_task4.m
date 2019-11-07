% y1 = x1
% y2 = x1'
% y3 = x2'
% y4 = x2'

function res = odefunc_task4(t, y, alpha, bounds)
    res = [y(2); -alpha * y(1); y(4); -alpha * y(3)];
end
