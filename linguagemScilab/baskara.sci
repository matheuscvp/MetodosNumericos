 function [r1,r2]=baskara(ps);
    // coeff(ps) - pega matriz de polinômios e retorna a matriz dos coeficiêntes
    coeficientes = coeff(ps);
    // delta = b^2 - 4ac
    delta = coeficientes(2)^2 -4*coeficientes(3)*coeficientes(1);
    r1=(-coeficientes(2) + sqrt(delta)) / (2*coeficientes(3))
    r2=(-coeficientes(2) - sqrt(delta)) / (2*coeficientes(3))
 endfunction
