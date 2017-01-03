function x_ct = center(X)
    
    [~,n] = size(X(1,:));
    x_c(1,1) = 1/n .* sum(X(1,:));
    x_c(2,1) = 1/n .* sum(X(2,:)); 
    
    for i = 1 : n
        x_ct(i,:) = X(:,i) - x_c;
    end
    x_ct = x_ct';
end

