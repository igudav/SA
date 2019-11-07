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
alpha = 0.1;
init_conds = [1; 1; 0; 1];
time = [0, 99 * pi];
opts = odeset('Events', @(t, y) event_task4(t, y, bounds), 'MaxStep', 5e-2, 'Refine', 4);
tres = [time(1)];
yres = init_conds';
te = time(1); % dummy value becauose there's no do-while loop
i = 0;
while ~isempty(te)
    time(1) = te;
    i = i + 1;
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
ax.XLim = [bounds(1:2)];
ax.YLim = [bounds(3:4)];
hold on;
comet(ax, yres(:, 1), yres(:, 3));

