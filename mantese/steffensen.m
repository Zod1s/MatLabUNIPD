function [xvec, scarti, iter] = steffensen(x0, fun, tol, itmax)
% function per l'implementazione del metodo di Steffensen
% per la soluzione dell'equazione f(x) = 0
% uso: [xvec,scarti,iter] = Steffensen(x0,fun,tol,itmax)
%
xold = x0;
iter = 0;
dif = 10 * tol;

xvec = x0;
scarti = [];

while abs(dif) > tol && iter < itmax

      dif = -(fun(xold)^2) / (fun(xold + fun(xold)) - fun(xold));
      xnew = xold + dif;
      xvec = [xvec xnew];
      scarti = [scarti abs(dif)];
      xold = xnew;
      iter = iter + 1;
end
