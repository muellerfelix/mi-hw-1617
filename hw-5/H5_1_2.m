clear all;

training = csvread('TrainingRidge.csv');
eps = 1e-15;

X = training(:,1:2)';

[~,n] = size(X(1,:));

x_c(1,1) = 1/n .* sum(X(1,:));
x_c(2,1) = 1/n .* sum(X(2,:));

for i = 1 : n
    x_ct(i,:) = X(:,i) - x_c;
end

% Check if sum is right
sum = 0;
for j = 1 : n
    sum = sum + x_ct(j,:);
end

if(sum(1) > eps || sum(2) > eps)
    'something went wrong.'
end

X_ct = x_ct' ;
 
C = (1/n) * (X_ct * X_ct'); 
  
% Whitening D values V vectors
[V,D] = eig(C);
%D = eig(C);
temp = zeros(2,2);
for i = 1 : 2
    temp(i,i) = 1/sqrt(D(i,i));
end

       
x_final = temp *(V'*X_ct);

figure
hold on;
%scatter(x_center(1),x_center(2),'red');
scatter(x_ct(:,1),x_ct(:,2),'bx');
scatter(x_final(1,:),x_final(2,:),'green');
hold off;


