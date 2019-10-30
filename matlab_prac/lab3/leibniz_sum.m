function res = leibniz_sum(n)
    res = ones(1, n);
    sgn = -1;
    for i = 2:n
        if sgn < 0
            res(i) = res(i - 1) - 1 / i;
        else
            res(i) = res(i - 1) + 1 / i;
        end 
        sgn = -sgn;
    end
end
