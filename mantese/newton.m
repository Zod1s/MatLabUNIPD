function [xvec, scarti, iter] = newton(x0, fun, dfun, tol, itmax)

xold = x0;
iter = 0;
dif = tol + 1;

xvec = x0;
scarti = [];

while abs(dif) > tol && iter < itmax
      iter = iter + 1;
      fx = fun(xold);  %% f(xk)
      dfx = dfun(xold); %% f'(xk)
      dif = -fx/dfx;
      xnew = xold + dif;
      xold = xnew;
      xvec = [xvec xnew];
      scarti = [scarti abs(dif)];
end