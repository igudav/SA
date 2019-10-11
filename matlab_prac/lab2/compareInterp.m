function compareInterp(x, xx, f, flag)
    if prod(ismember(x, xx)) ~= 1
        error(message(compareInterp:notembeddedgrid));
    end

    TRUE_FUNC_H = 1000;

    subplot(2, 2, 1);
    plot(x, f(x), '*', xx, interp1(x, f(x), xx, 'nearest'));
    if (nargin == 4)
        hold on;
        xxx = linspace(min(xx), max(xx), TRUE_FUNC_H);
        plot(xxx, f(xxx));
        hold off;
    end
    legend('f(x)', 'nearest interp', 'interpreter', 'latex');
    title('Nearest', 'interpreter', 'latex');
    
    subplot(2, 2, 2);
    plot(x, f(x), '*', xx, interp1(x, f(x), xx, 'linear'));
    if (nargin == 4)
        hold on;
        xxx = linspace(min(xx), max(xx), TRUE_FUNC_H);
        plot(xxx, f(xxx));
        hold off;
    end
    legend('f(x)', 'linear interp', 'interpreter', 'latex');
    title('Linear', 'interpreter', 'latex');

    subplot(2, 2, 3);
    plot(x, f(x), '*', xx, interp1(x, f(x), xx, 'spline'));
    if (nargin == 4)
        hold on;
        xxx = linspace(min(xx), max(xx), TRUE_FUNC_H);
        plot(xxx, f(xxx));
        hold off;
    end
    legend('f(x)', 'spline interp', 'interpreter', 'latex');
    title('Spline', 'interpreter', 'latex');

    subplot(2, 2, 4);
    plot(x, f(x), '*', xx, interp1(x, f(x), xx, 'pchip'));
    if (nargin == 4)
        hold on;
        xxx = linspace(min(xx), max(xx), TRUE_FUNC_H);
        plot(xxx, f(xxx));
        hold off;
    end
    legend('f(x)', 'pchip (cubic) interp', 'interpreter', 'latex');
    title('Pchip (cubic)', 'interpreter', 'latex');

end
