%% preparation

f = @(x) (sin(2 * x) .* log(x .^ 2));
x = linspace(1, 6, 1000);

%% dealing

EPS = 1e-3;

y = f(x);

idx = find(y < [0 y(1 : end-1)] & y < [y(2 : end) 0]);
y_max = max(y);
max_idx = find((y == y_max));
x_max = x(max_idx);
a = max_idx(end);
b = idx(find(abs(idx - a) == min(abs(idx - a))));
plot(x, y, x(idx), y(idx), 'o', x_max, y_max, 'o');
title('$y = f(x)$', 'interpreter', 'latex');
hold on;
if a < b
    comet(x(a:b), y(a:b));
else
    comet(fliplr(x(b:a)), fliplr(y(b:a)));
end
hold off;
