function [y_end, y_switch] = extend_traj(tspan, y0, alpha)
    
    t0 = tspan(1);
    T = tspan(2);
    y_switch = y0;

    if y0(3) == 1
        u = -alpha; 
        d = 1;
    else
        u = alpha ;
        d = -1;
    end
    
    while t0 < T
        opts = odeset('Events', @(t, y) event_y(t, y, d));
        [t, y, te, ye, ~] = ode45(@(t, y) odefunc(t, y, u), [t0, T], y0, opts);
        if ~isempty(ye)
            y_switch = [y_switch ye'];
        end

        y0 = y(end, :);
        t0 = t(end, :);
        u = -u;
        d = -d;
    end 

    y_end = reshape(y0, 4, 1);
end
