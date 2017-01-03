function output = train(X,y,lambda)
    [m,~] = size(X);
    output =  inv((X*X'+ lambda * eye(m)))*(X*y);
end