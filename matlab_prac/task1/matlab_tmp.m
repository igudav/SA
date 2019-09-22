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

delete matlab_tmp.m