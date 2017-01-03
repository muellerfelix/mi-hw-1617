clear;
close all;
% H2.1
% b) 
hold on;
nhid = 10;
y_all = zeros(401,100);

for i = 1 : 50 

    af = 2;
    
    % Generate the Parameters
    % b_i uniformly distributed [-2,2]
    % -> r = a + (b-a).*rand(N,1)
    b_i = -2 + 4*rand(nhid,1);

    % a_i [0,2], b_i [0,1]
    a_i = af * randn(nhid,1);
    w_i = randn(nhid,1);
    
    y = zeros(401,1);
    count = 1;
    %calculate the function
    for x = -2 : 0.01 : 2
        for n = 1 : nhid
            y(count) = y(count) + w_i(n) * tanh(a_i(n)*(x - b_i(n)));
        end
        count = count +1;
    end
    
    y_all (:,i) = y(:,1);
    
    xc = linspace(-2,2,401);
    plot(xc,y,'red');

end
title('ai element [0,2]');
hold off;

%c)
figure;
hold on;
for ii = 1 : 50
    
    af = 0.5;

    % Generate the Parameters
    % b_i uniformly distributed [-2,2]
    % -> r = a + (b-a).*rand(N,1)
    b_i = -2 + 4*rand(nhid,1);

    % a_i [0,2], b_i [0,1]
    a_i = af * randn(nhid,1);
    w_i = randn(nhid,1);
    
    y = zeros(401,1);
    count = 1;
    %calculate the function
    for x = -2 : 0.01 : 2
        for n = 1 : nhid
            y(count) = y(count) + w_i(n) * tanh(a_i(n)*(x - b_i(n)));
        end
        count = count +1;
    end
    
    y_all (:,ii+50) = y(:,1);
    
    xc = linspace(-2,2,401);
    plot(xc,y,'blac');

end
title('ai element [0,05]');
hold off;
% H2.1 
% c) compute mean square error between the functions
% with g(x) = -x;

% calculate g(x)

g = zeros(401,1);
cg = 1;
for xg = -2 : 0.01 : 2
    g(cg) = double(-xg)
    cg = cg + 1;
end

errors1 = zeros(50,1);
for all = 1 : 1 : 50
    errors1(all) =mean((y_all(:,all) - g).^2) ;
end

errors2 = zeros(50,1);
for all = 51 : 1 : 100
    errors2(all-50) = mean((y_all(:,all) - g).^2) ;
end

[min1,index1] = min(errors1);
[min2,index2] = min(errors2);

index2 = index2 + 50;

x = linspace(-2,2,401);
figure;
plot(x,g,'blue',x, y_all(:,index1),'red', x,y_all(:,index2),'black');
legend('f(x) = -x','a_i element [0,2]','a_i element [0,0.5]');
