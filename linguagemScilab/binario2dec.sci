// Binario para decimal, apenas inteiros positivos
function decimal = binario2dec(binario, bits)
    // ex: 2^3, 2^2, 2^1, 2^0 = [8,4,2,1]
    array_decimais = 2^(bits - 1:-1:0);
    // mutliplicação do binario (em linha) pelo array_decimais transposto (em linha)
    decimal = binario * array_decimais';
endfunction

// Binario para decimal, inteiros positivos e negativos (bit de sinal)
function decimal = binario2dec2(binario, bits)
    //bits - 2, pois o primeiro bit é de sinal
    array_decimais = 2^(bits - 2:-1:0);
    // eleva -1 ao primeiro bit do binario, se for 0 é positivo logo -1^0 = 1
    decimal = (-1)^binario(1) * binario(2:bits) * array_decimais';  
 endfunction

// Binario para decimal, inteiros positivos e negativos (complemento de 2)
function decimal = binario2dec3(binario, bits)
    sinal = binario(1)
    // Se o primeiro bit (bit de sinal) for 1 é porque o numero é negativo, logo complemento de 2
    if(binario(1) == 1) then
        // Inverte os bits
        binario = bitcmp(binario, 1)
        // Soma-se 1 ao último bit
        binario = SomaBinaria(binario , [zeros(1:bits - 1) 1])
    end
    decimal = (-1)^sinal * binario2dec(binario, bits);  
endfunction

// Binario para decima, reais positivos (pouco usado)
function decimal = binario2dec4(binario, bits1, bits2)
    array_decimal = 2^(bits1 - 1:-1:-bits2);
    decimal = binario * array+decimal';
endfunction
