clear all;
close all;
training = csvread('TrainingRidge.csv');
validation = csvread('ValidationRidge-Y.csv');
eps = 1e-15;

X_train = training(:,1:2)';
y_train = training(:,3);

X_valid = validation(:,1:2)';
y_valid = validation(:,3);

X_train_centerd = center(X_train);
X_train_whiten = whiten(X_train_centerd);

X_valid_centerd = center(X_valid);
X_valid_whiten = whiten(X_valid_centerd);

% plot training and validation set
figure;
hold on;
sz = 25;
subplot(2,1,1)
scatter(X_train_whiten(1,:),X_train_whiten(2,:),sz,y_train(:));
title('Training Set')
subplot(2,1,2)
scatter(X_valid_whiten(1,:),X_valid_whiten(2,:),sz,y_valid(:));
title('Validation Set')

%b)

valid_expand = expand(X_valid_whiten,10);
training_expand = expand(X_train_whiten,10);

% plot things n shit
yeah = true;
if yeah
    figure;
    title(' K = 0 to 3, after monomial Expansion.')
    hold on;

    for k = 1 : 10
        subplot(4,3,k)
        sz = 25;
        scatter(X_valid_whiten(1,:),X_valid_whiten(2,:),sz,valid_expand(k,:),'filled');
        colorbar;
    end
    hold off;
end


[MSE,std_devm,best_lambda] = cross_validate(training_expand,y_train,10);
lambda = log(10.^(-4:0.1:4));
figure;
hold on;
semilogx(lambda,MSE,'red')
errorbar(lambda,MSE,std_devm);
grid on;
title('Expanded Trainig Set')
xlabel('lambda')
ylabel('MSE')
hold off;

w_opt = train(training_expand,y_train,10^best_lambda);
y_predict= w_opt'*valid_expand;
figure;
subplot(2,1,1);
title('validation set');
scatter(X_valid_whiten(1,:),X_valid_whiten(2,:),sz,y_predict(:));
subplot(2,1,2);
title('validation set');
scatter(X_valid_whiten(1,:),X_valid_whiten(2,:),sz,y_valid(:));


% d)

[MSE2,std_devm2,best_lambda2] = cross_validate(valid_expand,y_valid,10);
lambda = log(10.^(-4:0.1:4));
figure;
hold on;
errorbar(lambda,MSE2,std_devm2);
grid on;
title('Expanded Validation Set')
xlabel('lambda')
ylabel('MSE')
hold off;

best_lambda
best_lambda2

