% a)
close all;
% Constants
maxIter = 30;

% dataset
x = [-1,0.3,2]';
t = [-0.1,0.5,0.5]';

X = zeros(2,3);
X(1,:) = 1;
X(2,:) = x(:);
% learning rate
eta = zeros(maxIter+1,1);
w = zeros(2,maxIter+1);
w(1,1) = rand(1);
w(2,1) = rand(1);
iter = 1;
H = X*X';
b = -X*t;

for iter = 1 : maxIter

    g = H * w(:,iter) + b;
    eta(iter) = g'* g / (g'*H*g);
    w(:,iter+1) = w(:,iter) - eta(iter) * g;
    
end


figure;
scatter(w(1,1:maxIter),w(2,1:maxIter));
title('w0 over w1');
xlabel('w1');
ylabel('w0');

figure;
hold on;
plot((0:maxIter-1),w(2,1:maxIter),'r');
plot((0:maxIter-1),w(1,1:maxIter),'g');
title('wi vs iterations');
legend('w1','w0');
hold off;