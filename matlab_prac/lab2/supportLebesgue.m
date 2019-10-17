function res = supportLebesgue(f, opts)
    res = @rho;

    function [val, point] = rho(l)
        
        N = size(l, 2);
        point = zeros(2, N);
        val = zeros(1, N);
        for i = 1:N
            [point(:, i), val(:, i)] = fmincon(@(x) -l(:, i)' * x, [0; 0],...
                [], [], [], [], [], [], @nonlcon, opts);
        end
        val = -val;

        function [c, ceq] = nonlcon(x)
            c = f(x);
            ceq = [];
        end
    end
end
