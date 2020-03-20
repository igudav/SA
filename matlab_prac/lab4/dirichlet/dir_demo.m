M = 156;
N = 256;
mu = 1.78;
z1 = 0;
z2 = 0;
x = linspace(0, 1, M);
y = linspace(0, 1, N);
[X, Y] = meshgrid(x, y);
xiHandle = @(x) uAnalytical(x, zeros(size(x)), z1, z2, mu);
etaHandle = @(y) uAnalytical(zeros(size(y)), y, z1, z2, mu);

sol = solveDirichlet(@(x, y) fGiven(x, y), xiHandle, etaHandle, mu, M, N);
surf(X, Y, sol, 'Edgecolor', 'None');
title('Numeric');
xlabel('x');
ylabel('y');
zlabel('u');
figure;
surf(X, Y, uAnalytical(X, Y, z1, z2, mu), 'Edgecolor', 'None');
title('Analytical');
xlabel('x');
ylabel('y');
zlabel('u');
figure;
d = real(sol) - uAnalytical(X, Y, z1, z2, mu);
max(abs(d), [], 'all')
surf(X, Y, d, 'Edgecolor', 'None');
xlabel('x');
ylabel('y');
zlabel('u');
title('Residual');

%% numeric only

M = 16;
N = 16;
x = linspace(0, 1, M);
y = linspace(0, 1, N);
[X, Y] = meshgrid(x, y);
sol = solveDirichlet(@(x, y) exp(x .^ 2 + 4 * y .^ 4), @(x) x.^2 .* (1 - x), ...
    @(y) y .* (1 - y.^3), 1, M, N);
figure;
surf(X, Y, sol, 'Edgecolor', 'None')
xlabel('x');
ylabel('y');
zlabel('u');
title('Numeric');
