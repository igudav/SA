function [position, isterminal, direction] = event_task4(t, y, bounds)
    position = [y(1) - bounds(1); y(1) - bounds(2); y(3) - bounds(3); y(3) - bounds(4)];
    isterminal = [1; 1; 1; 1];
    direction = [-1; 1; -1; 1];
end
