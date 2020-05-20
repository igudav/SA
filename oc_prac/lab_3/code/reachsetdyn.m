function reachsetdyn(alpha, t1, t2, N, filename)
    if t1 == t2 
        figure;
        [X, Y, ~, ~] = reachset(alpha, t1);
        plot(X, Y);
        xlabel('$x$', 'interpreter', 'latex');
        ylabel('$y$', 'interpreter', 'latex');
        s = strcat('reachable set at $t = ', string(t1), '$');
        title(s, 'interpreter', 'latex');

        return;
    end

    mov(1:N) = struct('cdata', [], 'colormap', []);
    t_grid = linspace(t1, t2, N + 1);

    [X, Y, ~, ~] = reachset(alpha, t2);
    xmin = min(X);
    xmax = max(X);
    ymin = min(Y);
    ymax = max(Y);

    sz = max([xmax - xmin, ymax - ymin]) * 0.1;

    xmin = xmin - sz;
    xmax = xmax + sz;
    ymin = ymin - sz;
    ymax = ymax + sz;

    for i = 1:numel(t_grid)
        T = t_grid(i);
        [X, Y, ~, ~] = reachset(alpha, T);
        plot(X, Y);
        xlabel('$x$', 'interpreter', 'latex');
        ylabel('$y$', 'interpreter', 'latex');
        s = strcat('reachable set at $t = ', string(T), '$');
        title(s, 'interpreter', 'latex');
        axis([xmin, xmax, ymin, ymax]);
        mov(i) = getframe;
        cla;
    end

    if nargin > 4
        f = VideoWriter(filename);
        open(f);
        writeVideo(f, mov);
        close(f);
    end

end
