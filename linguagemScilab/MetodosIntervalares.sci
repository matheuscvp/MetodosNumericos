// Bisseção 1 (função, limite minimo, limiti máximo, tolerancia)
function Bisseção(f,a,b,tol)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]",a,b)
       return
    end
    printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    // intereções baseada na quantidade de vezes no loop
    for (k=1:500)
        // abs = pega parte inteira do número, tamanho do intervalo
        erro=abs(b-a)
        // Bisseção
        x1=(a+b)/2
        // k = intereção, a = min, sinal da f(min), x1 = novo limite, sinal de x1, limite max, sinal de f(max), erro
        printf ("%d\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n",k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro)
        // Erro menor que a tolerância ou se a raiz do valor encontrado for 0
        if  ( (erro<tol) | (f(x1)==0) )
            break 
        end
        // Se f(a) * f(x1) < 0 troca o b, senão troca o a
        if f(x1)*f(a) < 0 
             b=x1
        else
             a=x1
        end   
    end
    printf ("\nraiz = %.10f(%2d) após %i iterações",x1,sign(f(x1)),k)
endfunction

// Bisseção 2 (função, limite minimo, limiti máximo, tolerancia)
function Bisseção2(f,a,b,tol)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]",a,b)
       return
    end
    printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    // salva como primeira resposta de x1 o a
    x1=a;
    erro=1;
    for (k=1:500)
        // salva o antigo intervalo (se primeira interação = a)
        x0=x1
        // Bisseção
        x1=(a+b)/2
        // <> equivalente á diferença
        if(x1<>0)
            // Calcula o erro relativo (X1(novo) - X0(velho)/ X1(novo)
            erro=abs((x1-x0)/x1)
        end
        // k = intereção, a = min, sinal da f(min), x1 = novo limite, sinal de x1, limite max, sinal de f(max), erro
        printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro)
        // Erro menor que a tolerância ou se a raiz do valor encontrado for 0
        if  ( (erro<tol) | (f(x1)==0) )
            break
        end
        // Se f(a) * f(x1) < 0 troca o b, senão troca o a
        if f(x1)*f(a) < 0 then
             b=x1
        else
             a=x1
        end
    end
    printf ("\nraiz = %.10f(%2d) após %i iterações",x1,sign(f(x1)),k)
endfunction

// Bisseção 3 (função, limite minimo, limiti máximo, tolerancia)
function Bisseção3(f,a,b,tol)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("Escolha outro intervalo pois f(a) e f(b) possuem o mesmo sinal")
       return
    end
    // n = quantidade de interações  log2((b-a)/tol) - log2 vira log10/log10(2), ceil = teto, arredondamento para cima
    n=ceil(log((b-a)/tol)/log(2))
    printf("Previsão de %d iterações\n",n)
    printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    for (k=1:n)
        // Bisseção
        x1=(a+b)/2
        // k = intereção, a = min, sinal da f(min), x1 = novo limite, sinal de x1, limite max, sinal de f(max), erro
        printf ("%d\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n",k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),abs(b-a))
        // Único teste necessario para ver a parada, se a raiz foi encontrada
        if  ( f(x1)==0 )
            break
        end
        // Se f(a) * f(x1) < 0 troca o b, senão troca o a
        if f(x1)*f(a) < 0 
             b=x1
        else
             a=x1
        end   
    end
    printf ("\nraiz = %.10f(%2d) após %i iterações",x1,sign(f(x1)),k)
endfunction

// Falsa Posição (função, limite minimo, limite máximo, tolerância)
function FalsaPosição(f,a,b,tol)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]",a,b)
       return
    end
    printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    x1=a;
    erro=  1;
    for (k=1:500)
        x0=x1
        // Falsa Posição
        x1=(a*f(b)-b*f(a))/(f(b)-f(a))
        // <> equivale a diferente
        if(x1<>0)
            // Erro equivalente  
            erro=abs((x1-x0)/x1)  
        end
        printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro)
        // Numero de interações ou erro menor que a tolerância
        if  ( (erro<tol) | (f(x1)==0) ) 
            break 
        end
        if f(x1)*f(a) < 0 then
             b=x1
        else
             a=x1
        end
    end
    printf ("\nraiz = %.10f(%2d) após %i iterações",x1,sign(f(x1)),k)
endfunction

// Falsa Posição Modificado (função, limite minimo, limite máximo, tolerância)
function FalsaPosiçãoModificado(f,a,b,tol)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]",a,b)
       return
    end
    printf ('i \ta\t\t\tx1\t\t\tb\t\t\terro\n')
    x1=a; 
    fa = f(a);
    fb = f(b);
    // na e nb representam a quantidade de vezes que a ou b se repetiram
    na=0; 
    nb=0; 
    for(k=1:500)
        x0=x1;
        // Falsa Posição Podificado
        x1=(a*fb-b*fa)/(fb-fa)
        fx1 = f(x1)
        // <> equivale a diferente
        if(x1<>0)
            // Erro equivalente
            erro=abs((x1-x0)/x1)  
        end
        printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',k,a,sign(f(a)),x1,sign(f(x1)),b,sign(f(b)),erro)
        // Numero de interações ou erro menor que a tolerância
        if  ( (erro<tol) | (f(x1)==0) )  
            break  
        end
        if fx1*fa < 0 then
            b=x1
            fb = fx1;
            nb=0;
            // Como foi o B que mudou, o continuou o mesmo logo soma-se 1
            na=na+1
            // Se a quantidade de repetições de A forem maior ou igual a 2, o limite a é dividido por 2
            if (na>=2)  
                fa = fa/2;  
            end
        else
            a=x1;
            fa = fx1;
            na=0;
            // Como foi o A que mudou, o continuou o mesmo logo soma-se 1
            nb=nb+1
            // Se a quantidade de repetições de B forem maior ou igual a 2, o limite a é dividido por 2
            if (nb>=2)  
                fb = fb/2;  
            end;
        end
    end
    printf ("\nraiz = %.10f(%2d) após %i iterações",x1,sign(f(x1)),k)
endfunction

// Multisseção (função, limite minimo, limite máximo, tolerância, )
function Multisseção(f,a,b,tol,N)
    // limite min e max de mesmo sinal - não tem raiz
    if (f(a)*f(b)>0) then
       printf("não há raiz no intervalo [%f,%f]]",a,b)
       return
    end
    // n = quantidade de interações  log2((b-a)/tol) - log2 vira log10/log10(N), ceil = teto, arredondamento para cima
    n=ceil(log((b-a)/tol)/log(N))
    printf("Previsão de %d iterações\n",n)
    printf ('i \ta\t\t\tb\t\t\tx1\t\t\terro\n')
    for (k=1:n)
        // Gera um espaço vetorial com N elementos de a até b (array de numeros)
        x=linspace(a,b,N)
        // Calcula todos os valores do espaço vetorial jogados na função
        fx1 = f(x)
        // min = menor valor do array, abs = apenas o valor absoluto. [valor mínimo, indice do valor mínimo no espaço vetorial]
        [f_min,index]=min(abs(fx1))
        // Erro absoluto dividido pela quantidade de elementos - 1 do espaço vetorial
        erro=abs(b-a)/(N-1)
        printf ( '%i\t%.10f(%2d)\t%.10f(%2d)\t%.10f(%2d)\t%.1e\n',k,a,sign(f(a)),b,sign(f(b)),x(index),sign(f(x(index))),erro)
        // Caso o valor da função no ponto mínimo do espaço vetorial seja 0
        if  (f(x(index))==0)  
            break  
        end 
        if f(x(index))*f(x(index+1)) < 0 
             a=x(index)
             b=x(index+1)
        else
             a=x(index-1)
             b=x(index)  
        end
    end
    printf ( '\nraiz = %.10f após %i iterações',x(index),k)
endfunction
