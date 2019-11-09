%% task1

% S = ln2
% |Rn| <= b_{n+1}
% psi(n) = 1/(n + 1)

n = 100;
Sn = leibniz_sum(n);
major = 1 ./ (1:n);
plot(1:n, Sn - log(2), 1:n, major);
xlabel('n', 'interpreter', 'latex');
legend('$S_n - S$', '$\psi(n)$', 'interpreter', 'latex')

%% task2

f = @(x) x .^ 3 + x + 1;
x = linspace(-2, 2, 1000);
plot(x, f(x), x, sin(x));
legend('$y = x^3 + x + 1$', '$y = \sin x$', 'interpreter', 'latex')
hold on;
[x0, y0] = ginput(1);
disp(fzero(@(x) f(x) - sin(x), x0));

%% task3

N = 1000;
x_stretching = 9; % magic coeff for fzero not to overstep close roots
func = @(x) func_task3(x, x_stretching);
x = linspace(-5 * x_stretching, 5 * x_stretching, N);
y = zeros(1, N);

for i = 1:N
    y(i) = 1 / x_stretching * fzero(func, x(i) * x_stretching);
end
plot(x ./ x_stretching, y ./ x_stretching, x ./ x_stretching, func(x));
legend('root', 'func');

%% task4

bounds = [-3 3 -3 3];
alpha = 0.15;
init_conds = [1; 2; 0; 1];
time = [0, 30 * pi];
opts = odeset('Events', @(t, y) event_task4(t, y, bounds), 'MaxStep', 5e-2, 'Refine', 4);
tres = [time(1)];
yres = init_conds';
te = time(1); % dummy value becauose there's no do-while loop
i = 0;
while ~isempty(te)
    time(1) = te;
    [t, y, te, ye, ie] = ode45(@(t, y) odefunc_task4(t, y, alpha, bounds),...
        time, init_conds, opts);
    nt = length(t);
    tres = [tres; t(2:nt)];
    yres = [yres; y(2:nt, :)];

    init_conds = y(nt, :)';    
    if ie < 3 % hit left or right bound
        init_conds(2) = -init_conds(2);
    else % hit floor or ceil
        init_conds(4) = -init_conds(4);
    end
end

ax = gca;
axis equal;
ax.XLim = [bounds(1:2)];
ax.YLim = [bounds(3:4)];
hold on;
comet(ax, yres(:, 1), yres(:, 3));

%% task5

G = 10;
m1 = 1;
m2 = 1;
x1_0 = [-1; 0];
x2_0 = [1; 0];
v1_0 = [0; 1];
v2_0 = [0; -1];
init_conds = [x1_0; v1_0; x2_0; v2_0];
time = [0 pi];
opts = odeset('MaxStep', 1e-1);

[t, y] = ode45(@(t, y) odefunc_task5(t, y, G, m1, m2), time, init_conds, opts);

N = size(y, 1);
mov1(1:N) = struct('cdata', [], 'colormap', []);

for i = 1:N
    plot(y(i, 1), y(i, 2), 'o', y(i, 5), y(i, 6), 'o');
    axis equal;
    axis([-2 2 -2 2]);
    mov1(i) = getframe();
end

G = 16;
m1 = 1;
m2 = 1;
x1_0 = [-1; 0];
x2_0 = [1; 0];
v1_0 = [0; 2];
v2_0 = [0; -2];
init_conds = [x1_0; v1_0; x2_0; v2_0];
time = [0 pi];
opts = odeset('MaxStep', 1e-1);

[t, y] = ode45(@(t, y) odefunc_task5(t, y, G, m1, m2), time, init_conds, opts);

N = size(y, 1);
mov2(1:N) = struct('cdata', [], 'colormap', []);

for i = 1:N
    plot(y(i, 1), y(i, 2), 'o', y(i, 5), y(i, 6), 'o');
    axis equal;
    axis([-2 2 -2 2]);
    mov2(i) = getframe();
end

%% task6

nphi = 8;
nr = 3;
min_r = 0.1;
max_r = 1.5;
phi = (1:nphi) * 2*pi / nphi;
r = linspace(min_r, max_r, nr);
N = 6;

funcs = {...
    @(t, y) [-5 * y(1); -3 * y(2)],...
    @(t, y) [2 * y(1); y(2)],...
    @(t, y) [-2 * y(1); -2 * y(2)],...
    @(t, y) [y(1); -y(2)],...
    @(t, y) [y(1) - 2 * y(2); y(2) + 3 * y(1)],...
    @(t, y) [y(2); -y(1)]...
};

titles = {...
    'Устойчивый узел',...
    'Неустойчивый узел',...
    'Дикритический узел',...
    'Седло',...
    'Фокус',...
    'Центр'...
};

tspans = {...
    [-5 5],...
    [-1 0],...
    [-5 5],...
    [-1 1],...
    [-0.1 1],...
    [0 pi]...
};

for i = 1:N
    subplot(2, 3, i);
    ode_phase_plot(cell2mat(funcs(i)), cell2mat(tspans(i)), r, phi, cell2mat(titles(i)));
end

%% task7

f1 = @(t, y) [y(1) .^ 3 - y(2); y(1) + y(2) .^ 3]; % неустойчива
f2 = @(t, y) [2 * y(2) .^ 3 - y(1) .^ 5; -y(1) - y(2) .^ 3 + y(2) .^ 5]; % устойчива
v1_func = @(y) y(:, 1) .^ 2 + y(:, 2) .^ 2;
v2_func = @(y) y(:, 1) .^ 2 + y(:, 2) .^ 4;

ncol = 20;
colors = parula(ncol);
nphi = 12;
nr = 4;
min_r = 0.1;
max_r = 1.5;
phi = (1:nphi) * 2*pi / nphi;
r = linspace(min_r, max_r, nr);
tspan = [0 20];

t1 = [];
y1 = [];

for i = 1:nphi 
    for j = 1:nr 
        [t_tmp, y_tmp] = ode45(f1, tspan, [r(j) * cos(phi(i)); r(j) * sin(phi(i))]);
        t1 = [t1; t_tmp];
        y1 = [y1; y_tmp];
    end
end

for i = 1:ncol 
    
end
