%% task1

ROWS = 20;
COLS = 300;

A = complex(rand(ROWS, COLS));
B = complex(rand(ROWS, COLS));
C = complex(rand(ROWS, COLS));

[X1, X2, X3] = cubesolve(A, B, C);

disp(X1);
disp(X2);
disp(X3);

disp(max(abs(A .* X1 .^ 3 + B .* X1 + C), [], 'all'));
disp(max(abs(A .* X2 .^ 3 + B .* X2 + C), [], 'all'));
disp(max(abs(A .* X3 .^ 3 + B .* X3 + C), [], 'all'));

%% task3

% mex -R2018a createspline_c.c;

% N = 13;
N = 5;
% f = @(x) exp(sin(2 * x));
f = @(x) sin(2 * x);
x_true = 0:N;
y_true = f(x_true);

xq = linspace(0, N, 101);

[A, B, C, D] = createspline_m(x_true, y_true);

% vq = interp1(x_true, y_true, xq, 'spline');
vq = spline(x_true, y_true, xq);
plot(xq, vq, 'k', x_true, y_true, 'ro');
hold on;
plot(xq, f(xq), 'b');

for i = 1:N
    
    x_cur = xq((xq >= x_true(i)) & (xq <= x_true(i + 1)));
    y_cur = A(i) + B(i) * (x_cur - x_true(i)) +...
        C(i) * (x_cur - x_true(i)) .^ 2 + D(i) * (x_cur - x_true(i)) .^ 3;
    plot(x_cur, y_cur, 'g');

end

legend('interp1', 'points', 'true func', 'createspline');

%% task4

N = 15;
len = ceil(logspace(1, 5, N));
t = zeros(N, 4);
REPS = 10;

for i = 1:N

    x = linspace(0, 10, len(i));
    xx = linspace(0, 10, 2 * len(i));
    f = x .^ 2;
    t_cur = zeros(1, REPS);

    for j = 1:REPS
        tic();
        [A, B, C, D] = createspline_c(x, f);
        t_cur(j) = toc();
    end
    t(i, 1) = median(t_cur);

    for j = 1:REPS
        tic();
        [A, B, C, D] = createspline_m(x, f);
        t_cur(j) = toc();
    end
    t(i, 2) = median(t_cur);

    for j = 1:REPS
        tic();
        y = spline(x, f, xx);
        t_cur(j) = toc();
    end
    t(i, 3) = median(t_cur);

    for j = 1:REPS
        tic();
        y = interp1(x, f, xx, 'spline');
        t_cur(j) = toc();
    end
    t(i, 4) = median(t_cur);
end
loglog(len, t);
legend('c', 'm', 'spline', 'interp1');
title('computation time');
xlabel('n');
ylabel('t');

%% task5

POW = 5;
alpha = regr(len, t, POW);
hold on;
M = [ones(1, numel(len)); cumprod(repmat(len, POW, 1))];
Y = M' * alpha;
loglog(repmat(len', 1, 4), Y, 'k');

