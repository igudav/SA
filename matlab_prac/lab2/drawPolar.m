function res = drawPolar(rho, N)

    opts = optimoptions('fmincon', 'display', 'none', 'algorithm', 'sqp');
    phi = linspace(0, N * 2 * pi / (N + 1), N);
    L = [cos(phi); sin(phi)];
    [vals, points] = rho(L);

    if min(vals) >= 0
        drawSet(supportLebesgue(@fLebesgue, opts), N);
    else
        % finding continuous segment with pos rho
        idx = find(vals > 0);
        idx_min_gap = find(diff(idx) > 1, 1) + 1;
        if isempty(idx_min_gap)
            idx_min_gap = 1;
        end

        idx = [idx(idx_min_gap:end), idx(1:idx_min_gap - 1)];
        L = L(:, idx);
        points = points(:, idx);
        vals = vals(idx);

        n_pos_points = numel(idx);
        plot(L(1, :) ./ vals, L(2, :) ./ vals);
        xmin = min(L(1, :) ./ vals);
        xmax = max(L(1, :) ./ vals);
        ymin = min(L(2, :) ./ vals);
        ymax = max(L(2, :) ./ vals);
    end

    hold on;
    drawSet(rho, N);
    axis([xmin, xmax, ymin, ymax]);
    legend('polar', 'int', 'ext');

    function res = fLebesgue(x);
        [v, p] = rho(x);
        res = v - 1;
    end
end
