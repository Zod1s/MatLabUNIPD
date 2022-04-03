t = -10:0.001:10;
y = ones(1, length(t));

for i = 1:length(t)
    y(i) = rep(t(i), 2, 1, 5);
end

figure
plot(t, y)
grid on

function d = rect(t)

    if abs(t) <= 0.5
        d = 1;
    else
        d = 0;
    end

end

function g = rep(t, T, a, n)
    sum = 0;

    for i = -n:n
        sum = sum + rect(a * (t - i * T));
    end

    g = sum;
end
