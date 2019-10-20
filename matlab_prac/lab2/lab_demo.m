%% task 2

x1 = -4:4;
xx1 = -4:0.25:4;
f1 = @sign;
disp('1st example: f(x) = sign(x), spline loose, linear perfect');
compareInterp(x1, xx1, f1);
disp('====================');
cont = input('insert some char to continue: ');

x2 = -4:4;
xx2 = -4:0.25:4;
f2 = @(x) x.^2;
disp('2nd example: f(x) = x^2, nearest loose');
compareInterp(x2, xx2, f2);
disp('====================');
cont = input('insert some char to continue: ');

x3 = -3:3;
xx3 = -3:1/4:3;
f3 = @(x) (x + 2) .* (x - 2) .* (x - 1) .* (x - 0.5);
disp('3rd example: f(x) = (x + 2)(x - 2)(x - 1)(x - 0.5), spline better than cubic');
compareInterp(x3, xx3, f3);
disp('====================');
cont = input('insert some char to continue: ');

x4 = -4:4;
xx4 = -4:0.25:4;
f4 = @sin;
disp('4th example: f(x) = sin(x), linear always not perfect, cubic is worse than spline');
compareInterp(x4, xx4, f4);

%% task 3

%       M2 * h^2
% R <=  --------
%          8
%
% f1(x) = exp(x), 0 <= x <= 4; M21 <~ 55;
% f2(x) = sin(4*pi*x), 0 <= x <= 4; M22 <~ 158;

f1 = @log;
f2 = @(x) x .^ 2;
H = 1 / 4;
FROM = 1;
TO = 5;
M21 = 1;
M22 = 2;
BIAS1 = M21 * H ^ 2 / 8;
BIAS2 = M22 * H ^ 2 / 8;

x = FROM:H:TO;
xq = FROM + H / 2 : H : TO - H/2;
y1_th = f1(xq);
y2_th = f2(xq);
y1_interp = interp1(x, f1(x), xq, 'linear');
y2_interp = interp1(x, f2(x), xq, 'linear');

subplot(2, 1, 1);
plot(xq, BIAS1 * ones(size(xq)), xq, abs(y1_th - y1_interp));
title('Prior and posterior biases on $\left[ 1, 5 \right]$', 'interpreter', 'latex');
legend('$\ln(x)$ prior', '$\ln(x)$ posterior', 'interpreter', 'latex');
subplot(2, 1, 2);
plot(xq, BIAS2 * ones(size(xq)), 'o', xq, abs(y2_th - y2_interp));
legend('$x^2$ prior', '$x^2$ posterior', 'interpreter', 'latex');

%% task4

a = 0;
b = 1;
convergenceFunc(@fn_pointwise, @flim_pointwise, a, b, 30, 'u');
convergenceFunc(@fn_pointwise, @flim_pointwise, a, b, 30, 'm');
convergenceFunc(@fn_meansq, @flim_meansq, a, b, 30, 'u');
convergenceFunc(@fn_meansq, @flim_meansq, a, b, 30, 'm');


%% task5

%% task7

f1 = @(t) sin(3 * t + pi / 2);
g1 = @(t) cos(4 * t);
t0 = 0;
t1 = pi;
tt1 = linspace(t0, t1, 1000);
p = getEqual(f1, g1, t0, t1, 7);
plot(f1(tt1), g1(tt1), p(1, :), p(2, :), '*');

p = getEqual(f1, g1, t0, t1, 100)
plot(f1(tt1), g1(tt1), p(1, :), p(2, :), '*');

f2 = @(t) sin(3 * t + pi / 4);
g2 = @(t) cos(5 * t);
t0 = 0;
t1 = pi;
tt2 = linspace(t0, t1, 1000);
p = getEqual(f2, g2, t0, t1, 7);
plot(f2(tt2), g2(tt2), p(1, :), p(2, :), '*');

p = getEqual(f2, g2, t0, t1, 27);
plot(f2(tt2), g2(tt2), p(1, :), p(2, :), '*');

%% task8

drawSet(@rhoCircle, 10);
drawSet(@rhoCircle, 100);
drawSet(@rhoSquareDiag, 10);
drawSet(@rhoSquareDiag, 100);

%% task9

opts = optimoptions('fmincon', 'display', 'none', 'algorithm', 'sqp');
f = @(x) sum(x .^ 2) - 1e-7;
drawSet(supportLebesgue(f, opts), 100);

opts = optimoptions('fmincon', 'display', 'none', 'algorithm', 'interior-point');
f = @(x) exp(sum(abs(x))) - 10;
drawSet(supportLebesgue(f, opts), 20);

opts = optimoptions('fmincon', 'display', 'none', 'algorithm', 'interior-point');
f = @(x) exp((x(1) - 3 * x(2)) ^ 2 + x(1) ^ 4) - 10;
drawSet(supportLebesgue(f, opts), 100);

%% task13


