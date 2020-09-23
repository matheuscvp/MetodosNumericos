// numero = numero para converter, bits = qtd de bits
function binario = dec2binario(numero, bits)
    // ex: 2^2, 2^1, 2^0
    vetor_bits = 2^(bits - 1:-1:0);
    // Divisão do numero pelo seu correspondente no array
    parte_inteira = int(numero./vetor_bits)
    // modulo = checa se o numero é par, se for par = 0, se for impar = 1
    binario = modulo(parte_inteira, 2)
endfunction
    
// numero = numero para converter, bits = qtd de bits (apenas POSITIVOS)
function binario = dec2binario1(numero, bits)
    // Validações
    if (numero > (2^bits) - 1) then
        printf("%d não pode ser reprentado com %d bits", numero, bits)
        return
    end
    if (numero < 0) then
        printf("Utilize inteiros positivos\n")
        return
    end
    
    binario = dec2binario(numero, bits)
endfunction

// numero = numero para converter, bits = qtd de bits (ex 8 bits: 7 bits de magnitude e 1 de sinal)
function binario = dec2binario2(numero, bits)
    // Validação
    if (numero < (-2^(bits - 1) - 1) | numero > (2^(bits - 1) - 1)) then
        printf("%d não pode ser reprentado com %d bits", numero, bits)
        return
    end
    
    binario = dec2binario(abs(numero), bits - 1)
    
    // Se o numero for negativo, acrecenta o bit 1
    if (numero >= 0) then
        binario = [0 binario]
    else
        binario = [1 binario]
    end
endfunction

// numero = numero para converter, bits = qtd de bits (ex 8 bits: 7 bits de magnitude e 1 de sinal) - COMPLEMENTO 2
function binario = dec2binario3(numero, bits) 
    if(numero < (-2^(bits - 1)) | numero > (2^(bits - 1) - 1)) then
        printf("%d não pode ser reprentado com %d bits", numero, bits)
        return
    end
    
    binario = dec2binario(numero, bits)
    // Complemento 2
    if(numero < 0) then
        // bitcmp = Inverte os bits
        binario = bitcmp(binario, 1)
        // somar 1
        binario = SomaBinaria(binario, [zeros(1:bits - 1) 1])
    end
endfunction

// numero = numero para converter, bits1 = qtd de bits para parte decimal (apenas POSITIVO, REAIS ou INTEIROS), bits2 = qtd de bits para parte fracionaria
function binario = dec2binario4(numero, bits1, bits2) 
    if(numero > (2^bits1) - 1) then
        printf("%d não pode ser reprentado com %d bits", numero, bits)
        return
    end
    
    // ex: 2^2, 2^1, 2^0, 2^-1, 2^-2
    vetor_bits = 2^(bits1 - 1:-1:-bits2);
    // Divisão do numero pelo seu correspondente no array
    parte_inteira = int(numero./vetor_bits)
    // modulo = checa se o numero é par, se for par = 0, se for impar = 1
    binario = modulo(parte_inteira, 2)
endfunction

// binario1 + binario2
function soma_binario = SomaBinaria(binario1, binario2)
    // Validação para ver se ambos possuem o mesmo tamanho
    if (length(binario1)<>length(binario2)) then
        printf("b1 e b2 devem ter o mesmo número de bits")
        return
    end
    
    vai_um = 0
    // Loop que vai do bit mais significativo até o menos significativo
    for(k = length(binario1):-1:1)
        // (1, k) pra salvar no formato de linha e não de coluna
        soma_binario(1, k) = binario1(k) + binario2(k) + vai_um
        vai_um = 0
        if soma_binario(k) == 2 then
            soma_binario(k) = 0
            vai_um = 1
        elseif soma_binario(k) == 3 then
            soma_binario(k) = 1
            vai_um = 1
        end
    end
endfunction

