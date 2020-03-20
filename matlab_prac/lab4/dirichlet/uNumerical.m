function uNumerical(u1Zero, u2Zero, mu)

    SZ = 500;

    xiHandle = @(x) uAnalytical(x, zeros(size(x)), u1Zero, u2Zero, mu);
    etaHandle = @(y) uAnalytical(zeros(size(y)), y, u1Zero, u2Zero, mu);
    sol = solveDirichlet(@fGiven, xiHandle, etaHandle, mu, SZ, SZ);
    x = linspace(0, 1, SZ);
    y = x;
    [X, Y] = meshgrid(x, y);
    surf(X, Y, sol);
    figure
    surf(X, Y, sol - uAnalytical(X, Y, u1Zero, u2Zero, mu), 'Edgecolor', 'None');
end
