function viewPossible(points, P, L)
    max_dist = P / L - 1;
    N = size(points, 2);
    p1 = repmat(shiftdim(points', -1), 3, 1);
    p2 = repmat(permute(shiftdim(points', -1), [2 1 3]), 1, 3);
    dists = sqrt(sum((p1 - p2) .^ 2, 3));

    t = linspace(0, 2 * pi, 100);
    ngrid = 100;
    X = repmat(points(1, :), ngrid, 1) + repmat(max_dist * cos(t'), 1, N);
    Y = repmat(points(2, :), ngrid, 1) + repmat(max_dist * sin(t'), 1, N);
    patch(X, Y, [0, 0.7, 0.3], 'EdgeColor', 'none');
    hold on
    plot(points(1, :), points(2, :), 'd');
    hold off;
    axis equal;
end

delete matlab_tmp.m