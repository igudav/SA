function [X, Y, Sx, Sy] = reachset(alpha, T)

    if T < 0.0001
        X = [0];
        Y = [0];
        Sx = [0];
        Sy = [0];
        return;
    end
    
    N_GRID = 100;

    tspan = [0 T];
    y0 = zeros(4, 1);
    opts = odeset('Events', @(t, y) event_y(t, y, -1));

    sol_pos = ode45(@(t, y) odefunc(t, y, alpha), tspan, y0, opts);

    t_pos_max = T;
    if ~isempty(sol_pos.xe)
        t_pos_max = sol_pos.xe;
    end

    opts = odeset('Events', @(t, y) event_y(t, y, 1));
    sol_neg = ode45(@(t, y) odefunc(t, y, -alpha), tspan, y0, opts);

    t_neg_max = T;
    if ~isempty(sol_neg.xe)
        t_neg_max = sol_neg.xe;
    end

    t_grid_pos = linspace(0, t_pos_max, N_GRID);
    t_grid_neg = linspace(0, t_neg_max, N_GRID);
    x_init_pos = deval(sol_pos, t_grid_pos);
    x_init_pos(3, :) = 1;
    x_init_neg = deval(sol_neg, t_grid_neg);
    x_init_neg(3, :) = -1;

    traj_ends = zeros(4, 0);
    switch_points = zeros(4, 0);

    for i = 1:size(x_init_pos, 2)
        [y_end, s] = extend_traj([t_grid_pos(i), T], x_init_pos(:, i), alpha);
        traj_ends = [traj_ends y_end];
        switch_points = [switch_points s];
    end

    switch_points = switch_points(:, end:-1:1);

    for i = 1:size(x_init_neg, 2)
        [y_end, s] = extend_traj([t_grid_neg(i), T], x_init_neg(:, i), alpha);
        traj_ends = [traj_ends y_end];
        switch_points = [switch_points s];
    end

    traj_ends = [traj_ends traj_ends(:, 1)];
    X = traj_ends(1, :);
    Y = traj_ends(2, :);
    Sx = switch_points(1, :);
    Sy = switch_points(2, :);
end
