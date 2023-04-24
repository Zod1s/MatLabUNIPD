function [xvec, scarti, iter] = aitken(x0, g, tol, itmax)

dif = tol * 10;
iter = 0;
xvec = x0;
scarti = [];
xold = x0;

while abs(dif) > tol && iter < itmax
    dif = -(g(xold) - xold)^2 / (g(g(xold)) - 2 * g(xold) + xold);
    xnew = xold +dif;
    xvec = [xvec, xnew];
    scarti = [scarti, abs(dif)];
    xold = xnew;
    iter = iter + 1;
end
