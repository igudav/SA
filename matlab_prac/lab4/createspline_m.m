function [A, B, C, D] = createspline_m(x, f)
    N = length(x) - 1;
    A = f(1:end-1);
    B = zeros(1, N);
    D = zeros(1, N);

    h = zeros(1, N);
    for i = 1:N
        h(i) = x(i + 1) - x(i);
    end

    AAA = zeros(1, N);
    for i = 2:N
        AAA(i) = 3 / h(i) * (f(i + 1) - f(i)) - 3 / h(i - 1) * (f(i) - f(i - 1));
    end

    l = ones(1, N + 1);
    m = zeros(1, N);
    z = zeros(1, N + 1);
    for i = 2:N
        l(i) = 2 * (x(i + 1) - x(i - 1)) - h(i - 1) * m(i - 1);
        m(i) = h(i) / l(i);
        z(i) = (AAA(i) - h(i - 1) * z(i - 1)) / l(i);
    end

    C = zeros(1, N + 1);

    for i = N:-1:1
        C(i) = z(i) - m(i) * C(i + 1);
        B(i) = (f(i + 1) - f(i)) / h(i) - h(i) * (C(i + 1) + 2 * C(i)) / 3;
        D(i) = (C(i + 1) - C(i)) / (3 * h(i));
    end

    C = C(1:end-1);
end
