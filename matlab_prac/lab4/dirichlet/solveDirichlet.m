function res = solveDirichlet(fHandle, xiHandle, etaHandle, mu, N, M)
    x = linspace(0, 1, N + 1);
    y = linspace(0, 1, M + 1);
    x = x(1:end-1);
    y = y(1:end-1);
    [X, Y] = meshgrid(x, y);
    phi = zeros(M, N);
    phi(2:M, 2:N) = fHandle(X(2:M, 2:N), Y(2:M, 2:N));
    phi = phi';
    B_tmp = ifft2(phi);
    C = -N^2 * 4 * (sin(pi * X)) .^ 2 - M ^ 2 * 4 * (sin(pi * Y)) .^ 2 - mu;
    C = C';
    xi = xiHandle(x(1:N));
    eta = etaHandle(y(1:M));
    C = 1 ./ C;
            
    A = zeros(M + N, M + N - 1); % для СЛАУ
    right = zeros(M + N, 1);
    
    for m = 1:M
        D = (sum(C))';
        D = ifft(D);
        D = D' / N;
        A(m, 1:M) = [D((mod(-(m - 1), M) + 1):M), D(1:(mod(-(m - 1), M)))];
    end

    D = fft(C, [], 2);
    D = ifft(D) / M;
    D = D';
    A(1:M, M+1:M+N-1) = D(:, 2:N);
    
    D = B_tmp.*C;
    D = sum(D);
    right = eta' - fft(D)';
    
    D = fft(C);
    D = ifft(D, [], 2) / N;
    A(M+1:M+N, 1:M) = D;
    
    for k = 1:N
        D = sum(C, 2);
        D = ifft(D);
        D = [D((N - k + 2):N); D(1:(N - k + 1))];
        D = D / M;
        A(k + M, M+1:M+N-1) = D(2:N);
    end
    
    D = B_tmp .* C;
    D = fft(sum(D, 2));
    right(M+1:M+N) = xi' - D;

    A(M + 1,:) = [];
    right(M + 1) = [];
    
    sys_sol = A \ right;

    phi(1, 1:M) = sys_sol(1:M);
    phi(2:N, 1) = sys_sol(M+1:M+N-1);
    
    B = ifft2(phi);
    A = B .* C;
   
    res = fft2(A);
    res = real(res');
end
