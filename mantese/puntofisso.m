function [xvec, scarti, iter] = puntofisso(x0, g, tol, itmax)
%PUNTOFISSO calcola una approssimazione del risultato della funzione usando
%il metodo del punto fisso
xvec = x0;
scarti = [];
iter = 0;

dif = 10 * tol;
xold = x0;

while abs(dif) > tol && iter < itmax
    xnew = g(xold);
    dif = xnew - xold;
    xvec = [xvec xnew];
    scarti = [scarti dif];
    xold = xnew;
    iter = iter + 1;
end
