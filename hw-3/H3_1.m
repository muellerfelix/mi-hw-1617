clear all
dat = load('RegressionData.txt');
% Initialization
% weigths and bias
% randomly from intervall [-0.5,0.5]
r = rand(33,1) -0.5;
eta = 0.5;

%define input including bias
x = dat(:,1);
% labels y_orignal
y_orig = dat(:,2);
dim = size(x);
n = zeros(10,3);
E_loc = zeros(10,3);
w = reshape(r(1:(dim(1))*3),dim(1),3); 
E = 1;
iter = 1;
storred_errors = zeros(3000);
y = 0;
while(abs(E) > 0.00001 && iter < 3000 )
    for j = 1:3                             % layers
        for i = 1:dim %input loop
            if(i<3) % tanh
                n(i,j) = tanh(x(i).*w(i,j));
            end
        end
    end
    y = sum(n');
    y = y';
    
%------------ local errors ---------------------------------%
    for j = 1:3
        for i = 1:dim
            E_loc(i,j) = (y(i)-y_orig(i))*((1-tanh((x(i)))^2)*w(i,j)); 
        end
    end
    
% ---------- quadratic error function --------------------- %
    for j = 1:3
        for i = 1:dim
            w(i,j) = w(i,j) - eta * (1/dim(1))*E_loc(i,j)/w(i,j);
        end
    end
    
    E = sum(sum(E_loc));
    storred_errors(iter) = sum(E); 
    iter = iter+1;
end
     
figure(1)
plot(storred_errors)
title(['Errorfunction with convergence after ',num2str(iter),' runs'])

figure(2)
plot(n(1:10,:))
title('Hidden neurons activation for all input points')

figure(3)
scatter(1:10,dat(:,2))

hold on
scatter(1:10,y(1:10),'r+')
title('Training data (blue) with corresponding y-values (red)') 
hold off

for i = 1:dim(1)
    diff(i) = abs(y_orig(i)-y(i));
end
figure(4)
hold on 
bar(diff)
title('Errors betwen Training Data and corresponding y-values.')    
hold off
       
        
