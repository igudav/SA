function lyap_quiv(f, tspan, radiuses, angles, v)
    
    ncol = 20;
    colors = parula(ncol);
    t = [];
    y = [];
    
    for r = radiuses
        for phi = angles
            [~, y_tmp] = ode45(@(t, y) f(y(1), y(2))', tspan,...
                [r * cos(phi); r * sin(phi)]);
            y = [y; y_tmp];
        end
    end

    vy = v(y);
    vmax = max(vy);
    vmin = min(vy);
    vsegments = linspace(vmin, vmax, ncol + 1);
    vsegments(end) = vsegments(end) + 1; % to avoid loosing max elem in inequality below

    gca;
    hold on;
    for i = 1 : ncol
        ycur = y(vsegments(i) <= vy & vy < vsegments(i + 1), :);
        u = f(ycur(:, 1), ycur(:, 2));
        quiver(ycur(:, 1), ycur(:, 2), u(:, 1), u(:, 2), 'Color', colors(i, :));
    end
    hold off;
    c = colorbar('Location', 'southoutside', 'Ticks', [0 1], 'TickLabels', [vmin vmax]);
    c.Label.String = 'Lyapunov function';
end
