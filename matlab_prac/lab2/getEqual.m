function points = getEqual(f, g, t0, t1, N)
    if N == 2
        points = [f(t0) f(t1); g(t0), g(t1)];
    else
        NGRID = 10000;
        EPS = 1e-2;

        converg_flag = 0;
        bad_iter = 0;

        t = linspace(t0, t1, NGRID);
        Dists = squareform(pdist([f(t); g(t)]'));
        idx = NaN(1, N);
        idx(1) = 1;

        for i = 2:NGRID
            idx(2) = i;
            for j = 3 : N - 1
                remaining_dists = Dists(idx(j - 1), :);
                remaining_dists(1:idx(j - 1)) = NaN;
                [dif, mins] = min(abs(remaining_dists - Dists(idx(1), idx(2))));
                if isnan(dif) | dif > EPS | mins(1) == N % nothing to do here any more
                    bad_iter = 1;
                    break;
                end
                idx(j) = mins(1); % consider closest point leads to solution
            end
            if bad_iter == 1
                bad_iter = 0;
                continue;
            end
            idx(N) = NGRID;
            if abs(Dists(idx(N), idx(N - 1)) - Dists(idx(1), idx(2))) < EPS
                converg_flag = 1;
                break;
            end
        end
        if converg_flag == 0
            error('Sorry, I diverged :=(');
        else
            points = [f(t(idx)); g(t(idx))];

            % comparing with uniform grid
            unif_grid = linspace(t0, t1, N);
            unif_dist = sum(diff([f(unif_grid); g(unif_grid)], 1, 2) .^ 2, 1) .^ 0.5;
            unif_mean = mean(unif_dist);
            unif_dev = std(unif_dist);
            res_dist = sum(diff(points, 1, 2) .^ 2, 1) .^ 0.5;
            res_mean = mean(res_dist);
            res_dev = std(res_dist);
            disp(strcat('uniform: ', num2str(unif_mean), ' +- ', num2str(unif_dev)));
            disp(strcat('result: ', num2str(res_mean), ' +- ', num2str(res_dev)));
        end
    end
%    save('debug.mat');
end
