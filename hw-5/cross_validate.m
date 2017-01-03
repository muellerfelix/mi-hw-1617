function [MSE,std_dev,best_lambda] = cross_validate(X,Y,nFolds)
    index = 1 ;
    best_lambda = 0;
    mse_min = 10e10;
    n = 200;
    samples_per_fold = n / nFolds;
    indizes = 1:n;
    std_dev = zeros(81,1);
    mse = zeros(81,nFolds);
    MSE = zeros(81,1);
    for m = -4:0.1:4 % iterate over all lambdas
        for f = 0 : nFolds-1 % do n - fold cross validation

            index_test =  indizes((f*samples_per_fold)+1 : (f+1)*samples_per_fold);
            index_train = [indizes(1:(index_test(1)-1))  indizes(index_test(samples_per_fold)+1:n)] ;

            X_test = X(:,index_test);
            y_test = Y(index_test,:);

            X_train = X(:,index_train);
            y_train = Y(index_train,:);

            % train
            w = train(X_train,y_train,10^m);
            
            % predicht
            y_predict      = w'*X_test;

            mse(index,f+1) = (y_test'-y_predict) * (y_test'-y_predict)';
        end
        MSE(index)  = mean(mse(index,:));
        std_dev(index) = std(mse(index,:));
        if(MSE(index)<mse_min)
            best_lambda = m;
        end
        index       = index +1;
    end