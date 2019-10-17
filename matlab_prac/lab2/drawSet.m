function res = drawSet(rho, N)
    
    % drawing outter approximation

    phi = linspace(0, N * 2 * pi / (N + 1), N);
    L = [cos(phi); sin(phi)];
    Ls = [L(:, 2:end) L(:, 1)];
    [V, P] = rho(L);
    Vs = [V(2:end) V(1)];
    % D = L(1, :) .* Ls(2, :) - L(2, :) .* Ls(1, :);
    % X = [(V .* Ls(2, :) - Vs .* L(2, :)) ./ D; (Vs .* L(1, :) - V .* Ls(1, :)) ./ D];
    % X = [X X(:, 1)];
    Y = zeros(2, N);
    for i = 1:N
        Y(:, i) = [L(:, i)'; Ls(:, i)'] \ [V(i); Vs(i)];
    end
    Y = [Y Y(:, 1)];
    P = [P P(:, 1)];
    plot(Y(1, :), Y(2, :), P(1, :), P(2, :));
    axis equal;
    legend('ext', 'int');
end
