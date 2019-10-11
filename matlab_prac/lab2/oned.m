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
