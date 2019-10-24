function viewPossible(points, P, L)
    max_dist = P / L - 1;
    N = size(points, 2);
    xmin = min(points(1, :)) - 5;
    xmax = max(points(1, :)) + 5;
    ymin = min(points(2, :)) - 5;
    ymax = max(points(2, :)) + 5;
    x = linspace(xmin, xmax, 1000);
    y = linspace(ymin, ymax, 1000);
    [X, Y] = meshgrid(x, y);
    Z = f(X, Y);

    save('debug.mat');
    [M, c] = contour(X, Y, Z, [L L]);
    c.Fill = 'on';
    hold on;
    scatter(points(1, :), points(2, :), '*', 'red');
    hold off;
    axis equal;
    if M(2, 1) < size(M, 2) - 1
        disp('Not connected');
    else 
        disp('Connected');
    end

    function Z = f(X, Y);
        Z = zeros(size(X));
        for i = 1:N
            Z = Z + P * ones(size(X)) ./ (ones(size(X)) + (X - points(1, i)) .^ 2 +...
                (Y - points(2, i)) .^ 2) .^ 0.5;
        end
    end
end
