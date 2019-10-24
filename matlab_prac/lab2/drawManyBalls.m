function res = drawManyBalls(alphas, colors, edges)
    sz = size(alphas);
    n = numel(alphas);
    [row, col] = size(alphas);

    for i = 1:n
        subplot(col, row, i)
        params = struct('fcol', colors(i), 'ecol', edges(i), 'n', 100, 'lvl', 1);
        drawBall(alphas(i), params);
        title(strcat('alpfa = ', num2str(alphas(i))));
    end
end
