function dy = odefunc(t, y, u)
    dy = zeros(4, 1);
    dy(1) = y(2);
    dy(2) = u - 2 * y(2) - y(1).^3 - y(1).^4 + y(1).^2 * sin(y(1));
    dy(3) = y(4) .* (3 * y(1).^2 + 4 * y(1).^3 - 2 * y(1) * sin(y(1)) - y(1).^2 * cos(y(1)));
    dy(4) = -y(3) + 2 * y(4);
end
