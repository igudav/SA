function [points, r] = getEqual(f, g, t0. t1, N)
    if N == 2
        points = [f(t0) f(t1); g(t0), g(t1)];
    elseif N == 3
        mid_x = 0.5(f(t0) + f(t1));
        mid_y = 0.5(g(t0) + g(t1));
    else
        
    end
end
