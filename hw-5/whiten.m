function x = whiten(X)
    
    [~,n] = size(X(1,:));
    C = (1/n) * (X * X'); 
    [V,D] = eig(C);
    temp = zeros(2,2);
    for i = 1 : 2
        temp(i,i) = 1/sqrt(D(i,i));
    end     
    x = temp *(V'*X);
end