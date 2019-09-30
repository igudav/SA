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

REP = 20;
FROM = 0;
TO = 15;
H_PLOT = 1 / 8;
MEAS_NUM_STEPS = 17;

% plotting antiderivative

x = FROM:H_PLOT:TO;
X = repmat(x, numel(x), 1);
Y = tril(sin(X) ./ X);
Y(isnan(Y)) = 1;
yr = rectangles(H_PLOT, Y, 2);
yt = trapz(H_PLOT, Y, 2);
ys = simpson(H_PLOT, Y, 2);
subplot(2, 2, [1 2]);
plot(x, yr, x, yt, x, ys);
title('$$\int\limits_0^x \frac{\sin{t}}{t}\,dt$$', 'interpreter', 'latex');
xlabel('x');
ylabel('Si(x)');
legend('rectangles', 'trapz', 'simpson');

% measuring errors and time

res_r = ones(1, MEAS_NUM_STEPS);
res_t = ones(1, MEAS_NUM_STEPS);
res_s = ones(1, MEAS_NUM_STEPS);
time_r = ones(REP, MEAS_NUM_STEPS);
time_t = ones(REP, MEAS_NUM_STEPS);
time_s = ones(REP, MEAS_NUM_STEPS);
diffs = cumprod(0.5 * ones(1, MEAS_NUM_STEPS));

for i = 1:MEAS_NUM_STEPS;
    x = FROM:diffs(i):TO;
    y = sin(x) ./ x;
    y(isnan(y)) = 1;
    for j = 1:REP
        tic();
        res_r(i) = rectangles(diffs(i), y);
        time_r(j, i) = toc();

        tic();
        res_t(i) = trapz(diffs(i), y);
        time_t(j, i) = toc();

        tic();
        res_s(i) = simpson(diffs(i), y);
        time_s(j, i) = toc();
    end
end

time_r = median(time_r);
time_t = median(time_t);
time_s = median(time_s);
err_r = abs(diff(res_r));
err_t = abs(diff(res_t));
err_s = abs(diff(res_s));

subplot(2, 2, 3);
loglog(diffs, time_r, diffs, time_t, diffs, time_s);
legend('rectangles', 'trapz', 'simpson');
xlabel('h');
ylabel('time');
title('computation time');

subplot(2, 2, 4);
loglog(diffs(2:end), err_r, diffs(2:end), err_t, diffs(2:end), err_s);
legend('rectangles', 'trapz', 'simpson');
xlabel('h');
ylabel('error');
title('internal convergance speed')

%% task13

MIN_DX = -8;
MAX_DX = 0;
POINTS = 1000;

der0 = cos(pi / 4);
dx = logspace(MIN_DX, MAX_DX, POINTS);
y = repmat(sin(pi / 4), 1,  POINTS);
f_x_plus_dx = sin(pi / 4 + dx);
der_right = (f_x_plus_dx  - y) ./ dx;
der_centr = (f_x_plus_dx - sin(pi / 4 - dx)) ./ (2 * dx);

loglog(dx, abs(der0 - der_right), dx, abs(der0 - der_centr));
legend('right diff', 'central diff');
xlabel('$h$', 'interpreter', 'latex');
ylabel('$\displaystyle \left| \frac{dy}{dx} - \frac{\Delta y}{\Delta x} \right|$',...
    'interpreter', 'latex');
