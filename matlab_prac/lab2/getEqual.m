function points = getEqual(f, g, t0, t1, N)
    if N == 2
        points = [f(t0) f(t1); g(t0), g(t1)];
    else
        NGRID = 5000;
        EPS = 3e-2;

        converg_flag = 0;
        t = linspace(t0, t1, NGRID);
        P = [f(t); g(t)]; % sample points from curve

        % calculating distance matrix
        p1 = repmat(shiftdim(P', -1), NGRID, 1);
        p2 = repmat(permute(shiftdim(P', -1), [2 1 3]), 1, NGRID);
        Dists = sqrt(sum((p1 - p2) .^ 2, 3));
        
        idx = zeros(1, N);
        idx(1) = 1;
        for i = 2:NGRID
            idx(2) = i;
            for j = 3 : N - 1
                remaining_dists = Dists(idx(j - 1), :);
                remaining_dists(1:idx(j - 1)) = NaN;
                [dummy, mins] = min(abs(remaining_dists - Dists(idx(1), idx(2))));
                if mins(1) == NGRID
                    break;
                end
                idx(j) = mins(1); % consider closest point leads to solution
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
        end
    end
end
