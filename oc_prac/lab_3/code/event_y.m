function [value, isterminal, direction] = event_y(t, y, d)
    value = y(2);
    isterminal = 1;
    direction = d;
end
