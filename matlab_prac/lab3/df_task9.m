function res = df_task9(x, idx)
    if idx == 1
        res = -2 + 2 * x(1) - 400 * x(1) * (x(2) - x(1) .^ 2);
    elseif idx == 2 
        res = 200 * (x(2) - x(1) .^ 2);
    end
end
