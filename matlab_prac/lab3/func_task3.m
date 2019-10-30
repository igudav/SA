function res = func_task3(x, kost)
    EPS = 1e-9;
    x = x ./ kost;

    res = zeros(size(x));
    idx = abs(x) > EPS;
    % idx = x ~= 0;
    res(idx) = x(idx) .* cos(log(abs(x(idx))));
end
