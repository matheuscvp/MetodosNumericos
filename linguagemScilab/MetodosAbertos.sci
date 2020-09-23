// Ponto Fixo (função, estimativa inicial, tolerancia)
function PontoFixo(f,x1,tol)
    // Define uma nova função g(x) = x + f(x)
    deff ( ' y=g ( x ) ' , ' y=f(x)+x' )
    // Erro Inicial
    erro = 1;
    printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
    for (k=2:500)
        x0=x1
        x1 = g(x0);
        //<> equivalente a diferente
        if(x1<>0) then
            // Erro Equivalente
            erro=abs((x1-x0)/x1)
        end
            printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        // Erro menor que a tolerância
        if  erro<tol then
            raiz = round(10*x1/tol)*tol/10
            break
        end
    end
    printf ( '\napós %i iterações raiz com tolerância %.1e = %.10f',k,tol,raiz)
endfunction

// Newton Raphson 1 (função, estimativa inicial, tolerancia)
function NewtonRaphson(f,x1,tol)
    // Interações
    iter = 0;
    // Erro inicial = 1
    erro = 1;
    printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
    // Começa em 2 pois o primeiro ja foi printado
    for (k=2:500)
        x0=x1
        // Calcula o valor no ponto x0, da função f
        f0=feval(x0,f)
        // numderivative = calcula a função da derivada f, no ponto x0
        df0=numderivative(f,x0)
        // Newton Raphson
        x1 = x0 - f0/df0
        //<> equivalente a diferente
        if(x1<>0) then
            // Erro relativo
            erro=abs((x1-x0)/x1)
        end
        printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        // Erro menor que a tolerância
        if  erro<tol then
            // round = arrendondamento para o inteiro mais próximo, pode ser pra baixo ou pra cima. Adiciona 1 decimal na 
            raiz = round(10*x1/tol)*tol/10
            break
        end
    end
    printf ( '\napós %i iterações raiz com tolerância %.1e = %.10f',k,tol,raiz)
endfunction

// Newton Raphson 1 (função, estimativa inicial, multiplicidade da raiz, tolerancia)
function NewtonRaphson2(f,x1,p,tol)
    // Interações
    iter = 0;
    // Erro inicial
    erro = 1;
    printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
    // Array de respostas
    for (k=2:500)
        x0=x1
        // Calcula o valor no ponto x0, da função f
        f0=feval(x0,f)
        // numderivative = calcula a função da derivada f, no ponto x0
        df0=numderivative(f,x0)
        // Newton Raphson multiplicado pela multiplicidade da raiz
        x1 = x0 - p*f0/df0
        //<> equivalente a diferente
        if(x1<>0) then
            // Erro relativo
             erro=abs((x1-x0)/x1)
        end
        printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        // Erro menor que a tolerância
        if  erro<tol then
            raiz = round(10*x1/tol)*tol/10
            break
        end
    end
    printf ( '\napós %i iterações raiz com tolerância %.1e = %.10f',k,tol,raiz)
endfunction

// Secante (função, limite minimo, limite máximo, tolerancia)
function Secante(f,x1,x2,tol)
    // Interações
    iter = 0;
    // Erro inicial
    erro = 1;
    printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
    for(k=2:500)
        x0=x1;
        x1=x2;
        f0=feval(x0,f)
        f1=feval(x1,f)
        df_x1 = (x1-x0)/(f1-f0);
        // x2 = x1 - f(x1) * x1-x0)/(f1-f0)
        x2 = x1 - f(x1)*df_x1;
        //<> equivalente a diferente
        if(x2<>0) then
            // Erro equivalente
            erro =abs((x2-x1)/x2)
        end
        printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        // Erro menor que a tolerância
        if  erro<tol then
            raiz = round(10*x2/tol)*tol/10
            break
        end
    end
    printf ( '\napós %i iterações raiz com tolerância %.1e = %.10f',k,tol,raiz)
endfunction

// Secante (função, estimativa inicial, incremento para o cálculo da derivada, tolerancia)
function SecanteModificado(f,x1,dx,tol)
    // Interações
    iter = 0;
    // Erro inicial
    erro = 1;
    if(dx==0) 
          then disp("dx deve ser diferente de zero")
          return
    end
    printf ( '%i\t%.10f\t%.1e\n',1,x1,erro)
    for (k=2:500)
        x0=x1
        // Calcula o valor no ponto x0, da função f
        f0=feval(x0,f)
        // numderivative = calcula a função da derivada f, no ponto x0 + dx (incremento do cálculo da derivada)
        f0_dx=feval(x0+dx,f)
        df0=dx/(f0_dx-f0)
        // x1 = x0 - f0*(dx)/(f0_dx-f0)
        x1 = x0 - f0*df0
        //<> equivalente a diferente
        if(x1<>0) then
            // Erro relativo
            erro=abs((x1-x0)/x1)
        end
        printf ( '%i\t%.10f\t%.1e\n',k,x1,erro)
        // Erro menor que a tolerância
        if  erro<tol then
            raiz = round(10*x1/tol)*tol/10
            break
        end
    end
    printf ( '\napós %i iterações raiz com tolerância %.1e = %.10f',k,tol,raiz)
endfunction
