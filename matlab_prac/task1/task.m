%% task1
promt = "a: ";
a = input(promt);
promt = "b: ";
b = input(promt);
promt = "n: ";
n = input(promt);
x = a : (b - a) / n : b;
y = sin(x + x .^ 2);

eps = 1e-3;
maxval = max(y);
maxidx = find(abs(y - maxval) < eps);
minval = min(y);
minidx = find(abs(y - minval) < eps);
xmin = x(minidx);
xmax = x(maxidx);
ymin = y(minidx);
ymax = y(maxidx);

plot(x, y, xmin, ymin, '.', xmax, ymax, '.', 'MarkerSize', 15);
xlabel('x');
ylabel('y');
title('Plot of the function $y = \sin\left(x + x^2\right)$',...
    'interpreter', 'latex');
legend({'$y = \sin\left(x + x^2\right)$', 'min', 'max'},...
    'interpreter', 'latex');

%% task2

promt = 'n: ';
n = input(promt);
if isnan(n) || fix(n) ~= n || n < 1
    error('bad input');
end

range = 9:18:n;
disp(range);

A = repmat((1:n)', 1, n);
disp(A);

B = reshape(1:n * (n + 1), n + 1, n)';
disp(B);

c = reshape(B, 1, []);
disp(c);

D = B(1:n, n:n + 1);
disp(D);

%% task3

n = 7;
A = ceil(rand(7) .* 50);
disp(A);

diag_max = max(diag(A));
disp(diag_max);

p = prod(A, 2);
s = sum(A, 2);
ratio = p ./ s;
disp(max(ratio));
disp(min(ratio));

disp(sortrows(A));

%% task4

promt = 'vector x: ';
x = input(promt);
promt = 'vector y: ';
y = input(promt);
disp(reshape(x, [], 1) * reshape(y, 1, []));

%% task5

promt = 'n: ';
n = input(promt);
if isnan(n) || fix(n) ~= n || n < 1 || ~isprime(n)
    error('bad input');
end

A = rand(n);
b = rand(n, 1);
eps = 1e-3;

if (abs(det(A)) < eps)
    error('bad matrix');
end

y = inv(A) * b;
disp(y);

disp(norm(A * y - b));

y = A \ b;
disp(y);

disp(norm(A * y - b));

%% task6

promt = 'vector a: ';
a = input(promt);
promt = 'vector b: ';
b = input(promt);
disp(max(max(a) - min(b), max(b) - min(a)));

%% task7

promt = 'Matrix: ';
Phi = input(promt);

n = size(Phi, 1);
k = size(Phi, 2);

A = repmat(sum(Phi .^ 2, 2), 1, n);
B = repmat(transpose(sum(Phi .^ 2, 2)), n, 1);

disp((A - 2 * Phi * Phi' + B) .^ 0.5);

%% task8

n = input('n: ');
disp(de2bi(0:2 ^ (n - 1)));

%% task9

REP = 50;
MAX_DIM = 100;

res_slow = zeros(MAX_DIM, 1);
res_fast = zeros(MAX_DIM, 1);

for n = 1:MAX_DIM
    
    A = rand(n);
    B = rand(n);
    t1 = zeros(REP, 1);
    t2 = zeros(REP, 1);

    for r = 1:REP
        tic();
        my_multiply(A, B);
        t1(r) = toc();

        C = zeros(n);
        tic();
        C = A * B;
        t2(r) = toc();
    end
    
    res_slow(n) = median(t1);
    res_fast(n) = median(t2);
end

x = 1:MAX_DIM;

plot(x, res_slow, x, res_fast);
xlabel('dimentiality of the matrices');
ylabel('time');
title('Dependence of time on method and dimensiality');
legend('stupid method', 'matlab built-in method');

%% task10

A = input('matrix: ');
cnt = sum(~isnan(A));
A(isnan(A)) = 0;
disp(sum(A) ./ cnt);

%% task11

n = input('n: ');
a = input('a: ');
s = input('sigma: ');

v = rand(n, 1);
v = norminv(v, a, s);
k = sum((v > a - 3 * s) & (v < a + 3 * s));

disp(k / n);

%% task12

REP = 50;
FROM = 0;
TO = 15;
diffs = cumprod(0.5 * ones(1, 16));

err_r = ones(1, numel(diffs));
err_t = ones(1, numel(diffs));
err_s = ones(1, numel(diffs));
time_r = ones(1, numel(diffs));
time_t = ones(1, numel(diffs));
time_s = ones(1, numel(diffs));

for h = diffs
    x = FROM:h:TO;
    X = repmat(x, numel(x), 1);
    Y = tril(sin(X) ./ X);
    Y(isnan(Y)) = 1;
    yr = rectangles(h, Y);
    yt = trapz(h, Y, 2);
    ys = simpson(h, Y);
end

plot(x, yr, x, yt, x, ys);

%% task13

MIN_DX = -4;
MAX_DX = 0;
POINTS = 1000;

der0 = cos(pi / 4);
dx = logspace(MIN_DX, MAX_DX, POINTS);
y = repmat(sin(pi / 4), 1,  POINTS);
der_right = (sin(pi / 4 + dx) - y) ./ dx;
der_centr = (sin(pi / 4 + dx) - sin(pi / 4 - dx)) ./ (2 * dx);

loglog(dx, abs(der0 - der_right), dx, abs(der0 - der_centr));
legend('right diff', 'central diff');
xlabel('$h$', 'interpreter', 'latex');
ylabel('$\displaystyle \left| \frac{dy}{dx} - \frac{\Delta y}{\Delta x} \right|$',...
    'interpreter', 'latex');
