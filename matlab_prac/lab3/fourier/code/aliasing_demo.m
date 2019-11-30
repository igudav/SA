fig = gcf;
fig.Position(4) = 250;
ax1 = subplot(1, 2, 1);
axis manual;
hold on;
ax2 = subplot(1, 2, 2);
axis manual;
hold on;
ax1.XAxisLocation = 'origin';
ax1.YAxisLocation = 'origin';
ax2.XAxisLocation = 'origin';
ax2.YAxisLocation = 'origin';
xlabel(ax1, '$\lambda$', 'interpreter', 'latex');
ylabel(ax1, '$\mathrm{Re} F(\lambda)$', 'interpreter', 'latex');
xlabel(ax2, '$\lambda$', 'interpreter', 'latex');
ylabel(ax2, '$\mathrm{Re} F(\lambda)$', 'interpreter', 'latex');
ax1.XLim = [-8 8];
ax1.YLim = [-0.5 1.2];
ax2.XLim = [-8 8];
ax2.YLim = [-0.5 1.2];

l = linspace(-15, 15, 10000);
shifts = (-4 * pi : 2 * pi : 4 * pi)';
L = repmat(l, 5, 1) + shifts * ones(1, 10000);
res = ftfunc1(L);
plot(ax1, repmat(l', 1, 5), real(res'), '-b');
plot(ax1, l, sum(real(res)), '-r');

shifts = (-4 * pi : 4 * pi : 4 * pi)';
L = repmat(l, 3, 1) + shifts * ones(1, 10000);
res = ftfunc1(L);
plot(ax2, repmat(l', 1, 2), real(res(1:2, :)'), '-b');
p1 = plot(ax2, l, real(res(3, :)'), '-b');
p2 = plot(ax2, l, sum(real(res)), '-r');

legend([p1 p2], {'multiplied FT', 'sum of FTs'}, 'interpreter', 'latex',...
    'Position', [0.45 0.8 0.15 0.1], 'AutoUpdate', 'off');        
