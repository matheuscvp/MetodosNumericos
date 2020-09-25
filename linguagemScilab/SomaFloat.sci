// valor1 e valor2 são numeros decimais/reais
function resultado = SomaFloat(valor1, valor2 , bits_expoente, bits_mantissa)
    // Valor 1 convertido para ponto flutuante
    [ponto_flutuante1, decimal1] = dec2float(valor1, bits_expoente, bits_mantissa)
    // Valor 2 convertido para ponto flutuante
    [ponto_flutuante2, decimal2] = dec2float(valor2, bits_expoente, bits_mantissa)
    printf("x1     = ")
    printFloat(ponto_flutuante1, bits_expoente, bits_mantissa, 1)
    printf("x2     = ")
    printFloat(ponto_flutuante2, bits_expoente, bits_mantissa, 1)
    
    // Armazena o sinal do primeiro (no caso sempre do maior)
    sinal_soma = ponto_flutuante1(1)
    // Necessidade de se entrar primeiro com um valor positivo maior
    if ((sinal_soma) | (abs(valor2) > abs(valor1)))
        printf("x1 deve ter maior módulo e ser positivo")
        return
    end
    
    // Separação do ponto flutuante em expoente e mantissa (com bit extra)
    expoente1  = ponto_flutuante1(2 : bits_expoente + 1)
    expoente2  = ponto_flutuante2(2 : bits_expoente + 1)
    mantissa1  = [0 1 ponto_flutuante1(bits_expoente + 2 : bits_expoente + bits_mantissa)]
    mantissa2  = [0 1 ponto_flutuante2(bits_expoente + 2 : bits_expoente + bits_mantissa)]
    
    // Calculo do deslocamento (decimal(expoente maior) - decimal(expoente menor)
    deslocamento = binario2dec(expoente1, bits_expoente) - binario2dec(expoente2, bits_expoente);
    // Criação de um array de bits 0 de tamanho bits_mantissa + 1, ex: bits_mantissa = 4, array armazenará 5 valores
    mantissa2_deslocada = zeros(1 : bits_mantissa + 1)
    // Inicia do deslocamento, pois assim sempre ficara 0's a esquerda
    // A mantissa2 só irá até bits_mantissa - deslocamento, pois depois do deslocamento todos os bit serão excluidos
    mantissa2_deslocada(deslocamento + 1 : bits_mantissa + 1) = mantissa2(1 : bits_mantissa + 1 - deslocamento)
    
    // Deslocamento máximo atingido, ou seja, equivalente ao número de bits da mantissa
    if(deslocamento >= bits_mantissa)   
        printf("deslocamento máximo atingido\n")
    end
    
    // Montagem do ponto flututante 2 ja deslocado [sinal expoente(igual ao 1) mantissa_deslocada]
    ponto_flutuante2_deslocado = [ponto_flutuante2(1) expoente1 mantissa2_deslocada(3 : bits_mantissa + 1)]
    printf("mantissa x2 deslocada -> de %d bits\n", deslocamento)
    printf("x2d    = ")
    printFloat(ponto_flutuante2_deslocado, bits_expoente, bits_mantissa, mantissa2_deslocada(2))

    // Segundo número é negativo (complemento de dois)
    if ponto_flutuante2(1) then
        // Inversão dos bits da mantissa deslocada
        mantissa2_deslocada = bitcmp(mantissa2_deslocada, 1)
        // Soma + 1 (complemento de dois)
        mantissa2_deslocada = SomaBinaria(mantissa2_deslocada,[zeros(1 : bits_mantissa) 1])
        // Novo ponto flutuante 2, ja deslocado e convertido para positivo via complemento de dois
        ponto_flutuante2_deslocado = [ponto_flutuante1(2) expoente1 mantissa2_deslocada(3 : bits_mantissa + 1)]
        printf("--------------------\n")
        printf("x2d(c2)= ")
        printFloat(ponto_flutuante2_deslocado, bits_expoente, bits_mantissa, mantissa2_deslocada(2))
        printf("x1     = ")
        printFloat(ponto_flutuante1, bits_expoente, bits_mantissa, 1)
        printf("-------------------- +\n")
        // Soma das mantissas
        mantissa_soma = SomaBinaria(mantissa1, mantissa2_deslocada)
        // Montagem do ponto flutuante da soma deslocado [sinal expoente (igual ao 1) soma_mantissas]
        soma_deslocada = [sinal_soma expoente1 mantissa_soma(3 : bits_mantissa + 1)]
        printf("soma_d = ")
        printFloat(soma_deslocada, bits_expoente, bits_mantissa, mantissa_soma(2))
        // Procura por 1's na mantissa, armazenando as posições
        lista_uns = find(mantissa_soma(1 : bits_mantissa + 1) == 1)
        
        // Se possuir ao menos 1 "um" na mantissa para mover este bit para o bit extra
        if(lista_uns <> [])
            // Calcula o deslocamento para a esquerda
            deslocamento = lista_uns(1) - 1
            // Calcula os expoente sendo a soma do expoente 1 com o complemento de 2 do deslocamento negativo mais 1
            expoente_soma = SomaBinaria(expoente1, dec2binario3(-deslocamento + 1, bits_expoente))
            // Cria uma mantissa temporária
            mantissa_temp = zeros(1 : bits_mantissa + 1)
            // Vai até a soma da quantidade de bits da mantissa + 2 - o deslocamento(o máximo sera sempre bits da matissa - 1)
            // sobrando 0's a direita
            // Inicia na localidade do primeiro 1 para ele representar o bit extra
            disp(mantissa_soma)
            mantissa_temp(1 : bits_mantissa + 2 - deslocamento) = mantissa_soma(deslocamento : bits_mantissa + 1)
            // Cria a soma final sendo [sinal expoente(calculado) mantissa(calculada)]
            soma = [sinal_soma expoente_soma mantissa_temp(3 : bits_mantissa + 1)] 
            printf("mantissa soma deslocada de <- %d bits\n", deslocamento - 1)
        // Não possui 1's na mantissa, logo o deslocamento foi maior que o Epsilon da máquina
        else
            printf("mantissa soma com deslocamento -> maior que 24 bits\n")
            soma = zeros(1 : bits_expoente + bits_mantissa)
        end
    // Os dois numeros são positivos
    else
        printf("--------------------\n")
        printf("x2d    = ")
        printFloat(ponto_flutuante2_deslocado, bits_expoente, bits_mantissa, mantissa2_deslocada(2))
        printf("x1     = ")
        printFloat(ponto_flutuante1,bits_expoente, bits_mantissa, 1)
        printf("-------------------- +\n")
        // Soma das mantissas
        mantissa_soma = SomaBinaria(mantissa1, mantissa2_deslocada)
        
        // Bit extra da mantissa não é mais 1 pois na soma acabou sobrando 1
        if(mantissa_soma(1) == 1)  then
            // Criação da soma deslocada [sinal expoente(igual ao 1) mantissa_somada(não contando os dois primeiros bits, ou seja bit extra)]
            soma_deslocada = [sinal_soma expoente1 mantissa_soma(3 : bits_mantissa + 1)]
            printf("soma_d = ")
            printFloat(soma_deslocada, bits_expoente, bits_mantissa, mantissa_soma(2))
            printf("Vai um! mantisa soma delocada de -> 1 bits\n")
            // Calculo do expoente, ou seja o expoente do primeiro somado 1 do vai um
            expoente_soma = SomaBinaria(expoente1,[zeros(1 : bits_expoente - 1) 1])
            // Ponto flutuante calculado [sinal expoente(calculado) mantissa]
            soma = [sinal_soma expoente_soma mantissa_soma(2 : bits_mantissa)]
        // Caso o bit extra não seja 0
        else
            // expoente será o mesmo que o expoente do 1
            expoente_soma = expoente1
            soma = [sinal_soma expoente_soma mantissa_soma(3 : bits_mantissa + 1)]
        end
    end
    printf("soma   = ")
    printFloat(soma, bits_expoente, bits_mantissa, 1)
    resultado = float2dec(soma, bits_expoente, bits_mantissa)
    printf("Soma binária (%d,%d)  = %.10f\n", bits_expoente, bits_mantissa, resultado) 
    printf("Soma exata           = %.10f\n", valor1 + valor2) 
 endfunction
