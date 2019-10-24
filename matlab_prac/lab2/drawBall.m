function drawBall(alpha, params)
    
    if params.n > 100
        error('N > 100?! R U ******* serious?!');
    end

    if isinf(alpha)
        f = @(x, y, z) max(max(abs(x), abs(y)), abs(z));
    else
        f = @(x, y, z) abs(x) .^ alpha + abs(y) .^ alpha + abs(z) .^ alpha;
    end

    t = linspace(-params.lvl - 1, params.lvl + 1, params.n);
    [X, Y, Z] = meshgrid(t, t, t);
    W = f(X, Y, Z);
    [f, v] = isosurface(X, Y, Z, W, params.lvl);

    if isempty(v)
        error('Empty isosurface!');
    else
        p = patch('Faces', f, 'Vertices', v);
        isonormals(X, Y, Z, W, p);
        p.FaceColor = params.fcol;
        p.EdgeColor = params.ecol;
        daspect([1 1 1]);
        view(3);
        axis tight;
        camlight;
        lighting gouraud;
    end
end
