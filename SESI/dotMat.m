v1 = [1; 9];
v2 = [2; 5];
v3 = [3; 6];
v4 = [4; 7];
u1 = [3; 7];
u2 = [2; 4];
u3 = [2; 6];
u4 = [4; 9];

U = [u1 u2 u3 u4];
V = [v1 v2 v3 v4];

R = dotProd(U, V);
disp(R(3));

function p = dotProd(A, B)
    l = size(A);
    l = l(2);
    v = zeros(1, l);

    for i = 1:l
        v(i) = A(:, i)' * B(:, i);
    end

    p = v;
end
