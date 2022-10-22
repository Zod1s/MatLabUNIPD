%% ES 1
foo1([0.4 0.1 0.5 0.9 0.8])

%% ES 2

foo2(1, [1 2 3 4 5], 0)

%% ES 3

foo3([-1, 0, 1]);

%% FUNZIONI

function v = foo1(v)
    flag = 1;
    while flag
        flag = 0;
        for i = 1:length(v) - 1
            if v(i) > v(i + 1)
                temp = v(i);
                v(i) = v(i + 1);
                v(i + 1) = temp;
                flag = 1;
            end
        end
    end
end

function y = foo2(k, x, y0)
    yo = y0;
    for i = 1:length(x)
        y(i) = yo * k + x(i);
        yo = y(i)
    end
end

function [a, b, c] = foo3(v)
     a = 0;
     ss = 0;
     for i = 1:length(v)
        a  = a + v(i);
     end
     a
     b = a / length(v)
     for i = 1:length(v)
         ss = ss + (v(i) - b) ^ 2;
     end
     c = ss / (length(v) - 1)
end
