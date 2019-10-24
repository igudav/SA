%% preparation

f = @(x, y, t) exp(-x .^ 2 * cos(2 * t) ^ 2 - y .^ 2 * sin(t) ^ 2) +...
    exp((x - 0.5) .^ 2 * cos(t + 0.4) ^ 2 + y .^ 2 * sin(1.3 * t - 0.4) ^ 2);
N = 100;
x = linspace(-0.7, 1, N);
y = linspace(-1, 1, N);
[X, Y] = meshgrid(x, y);

%% surfing

nFrames = 100;
t = linspace(pi, 3 * pi / 2, nFrames);
mov(1:nFrames) = struct('cdata', [], 'colormap', []);

for i = 1:nFrames 
    Z = f(X, Y, t(i));
    Zu = [Z(2:end, :); NaN(1, N)];
    Zd = [NaN(1, N); Z(1 : end - 1, :)];
    Zr = [NaN(N, 1) Z(:, 1 : end - 1)];
    Zl = [Z(: , 2:end) NaN(N, 1)];
    mins = Z <= Zu & Z <= Zd & Z <= Zr & Z <= Zl;
    maxs = Z >= Zu & Z >= Zd & Z >= Zr & Z >= Zl;
    s = surf(X, Y, Z);
    s.EdgeColor = 'none';
    hold on;
    scatter3(X(mins), Y(mins), Z(mins), 50, 'm', '*');
    scatter3(X(maxs), Y(maxs), Z(maxs), 50, 'k', '*');
    hold off;
    % xlabel('x');
    % ylabel('y');
    % legend('z = f(x, y | t)', 'loc min', 'loc max');
    title('surface evolution');
    axis([-1 1 -0.5 0.5 1 2.5]);
    mov(i) = getframe();
end

%% playing

movie(mov);

%% projections

t_fix = t(38);
level = 1.794;
contour(X, Y, Z, [1, level]);

%% save to .mat

save('surfing.mat', 'mov');

%% save to .avi

v = VideoWriter('surfing.avi');
open(v);
writeVideo(v, mov);
close(v);
