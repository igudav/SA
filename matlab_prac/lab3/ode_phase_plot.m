function res = ode_phase_plot(f, tspan, radiuses, angles, ttl)
    for r = radiuses
        for phi = angles
            [~, y] = ode45(@(t, y) f(y(1), y(2))', tspan, [r * cos(phi); r * sin(phi)]);
            u = f(y(:, 1), y(:, 2));
            save('debug.mat');
            quiver(y(:, 1), y(:, 2), u(:, 1), u(:, 2), 'b')
            title(ttl);
            hold on;
        end
    end
hold off;
end
