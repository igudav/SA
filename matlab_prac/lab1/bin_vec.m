function v =  bin_vec(n)
    if n == 1
        v = [0; 1];
    else 
        v1 = bin_vec(n - 1);
        v2 = bin_vec(n - 1);
        v1 = [zeros(2 ^ (n - 1), 1), v1];
        v2 = [ones(2 ^ (n - 1), 1), v2];
        v = [v1; v2];
    end
end
