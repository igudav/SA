function [value, isterminal, direction] = event_psi(t, x)
    value = x(4)
    isterminal = 1
    direction = 1
end
