clear
close all;

% general

mat = csvread('applesOranges.csv');
[r,c] = size(mat);
x1 = mat(:,1);
x2 = mat(:,2);
y = mat(:,3);
x=1:200;

% Excercise a)
figure;
hold on;
for x = 1:200
    if(y(x) == 0)
        plot(x1(x),x2(x),'ro');
    else
        plot(x1(x),x2(x),'bo');
    end
end
title('x1 plotted over x2');
xlabel('x1');
ylabel('x2');
hold off;


% ____Excercise b)_______________________________________
w1 = zeros(19,1);
w2 = zeros(19,1);
  
for k = 0:18
    w1(k+1,1) = cos(k*(pi/18));
    w2(k+1,1) = sin(k*(pi/18));
end


% Trefferrate berrechnen
res = zeros(19,1);
for w = 1 : 19
    
    for xn = 1:200
        temp = sign([w1(w),w2(w)]*[x1(xn),x2(xn)].');
        if(temp == -1)
            temp = 0;
        end
        if( temp == y(xn))
           res(w) = res(w)+1;
        end
    end
    res(w) = res(w)/200;
end

[im,in] = max(res);
alpha = 0:10:180;
figure;
plot(alpha,res);
title('alpha plotted against the performance');
xlabel('alpha');
ylabel('performance in %')


%_______________EXCERCISE C)_____________%

resc = zeros(601,1);
step = 0.01;
lauf = 1;

for sigma = -3 : step : 3
    pos =0;
    
    for xnn = 1 : 200
        temp = sign( ( [w1(in),w2(in)]*[x1(xnn),x2(xnn)].') - sigma );
        if(temp == -1) 
            temp = 0;
        end
        if( temp == y(xnn))
            pos = pos+1;
        end

    end
    resc(lauf) = pos/200;
    lauf = lauf+1;
end

[mm,i] = max(resc);
best_sigma = -3 + i*step;
z = linspace(-3,3,601);
figure;
plot(z,resc);
title('notneeded');

%_______EXCERCISE 1 D)_________%
% Make some fancy plots, yeah
true_class = zeros(200,1);

for xnnn = 1 : 200
    tempn = sign( ( [w1(in),w2(in)]*[x1(xnnn),x2(xnnn)].') - best_sigma );
    if(tempn == -1) 
        tempn = 0;
    end
    if( tempn == y(xnnn))
        true_class(xnnn) = 1;
    end
end

figure;
hold on;
for xy = -2:0.01:2
    plot(xy,(-(w1(in)/w2(in))*xy),'blue');
end

for xx = 1:200
    if(true_class(xx) == 1)
        plot(x1(xx),x2(xx),'go');
    else
        plot(x1(xx),x2(xx),'ro');
    end
    
end
title('best vector w with x1 and x2');
legend('vector w');
hold off;


%_______EXCERCISE 1 E)_________%
% Find all possible combinations

resc2 = zeros(19,121);
step2 = 0.1;

for w = 1 : 19
    lauf_sigma = 1;
    for sigma = -6 : step2 : 6
        pos =0;
        for xnn = 1 : 200
            temp2 = sign( ( [w1(w),w2(w)]*[x1(xnn),x2(xnn)].') - sigma );
            if(temp2 == -1) 
                temp2 = 0;
            end
            if( temp2 == y(xnn))
                pos = pos+1;
            end

        end
        resc2(w,lauf_sigma) = pos/200;
        lauf_sigma = lauf_sigma+1;
    end
end

HeatMap(resc2','COLORMAP',redbluecmap);
%Colormap(resc2)