function all = expand(X,numK)
    g = 1;
    [j,l] = size(X);
    for k = 0 : numK
        a=0;
        b=k;
        for iter = 1 : k 
            temp = zeros(l,1);
            for n = 1:l
                temp(n) = X(1,n) ^ a * X(2,n) ^ b;
            end 
            all(g,:) = temp(:);
            a = a+1;
            b = b-1;

        end
        g = g+1;
    end
end