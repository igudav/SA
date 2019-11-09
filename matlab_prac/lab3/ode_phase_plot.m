function res = ode_phase_plot(f, tspan, radiuses, angles, ttl)
    for r = radiuses
        for phi = angles
            [~, y] = ode45(f, tspan, [r * cos(phi); r * sin(phi)]);
            quiver(y(1 : end-1, 1), y(1 : end-1, 2),...
               diff(y(:, 1)), diff(y(:, 2)) , 'b');
            title(ttl);
            hold on;
        end
    end
hold off;
end
