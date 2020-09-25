// Transforma numero (real, inteiro, negativo) para ponto flutuante
function [ponto_flutuante, decimal] = dec2float(numero, bits_expoente, bits_mantissa)
    // Bit de sinal
    if (numero < 0) then sinal = 1 else sinal = 0 end
    
    // Expoente limite (min = negativo, max = positivo)
    expoente_limite = 2^(bits_expoente - 1)
    
    // Expoente do numero (parte inteira, para baixo, de log2(|numero|))
    expoente = floor(log2(abs(numero)))
    if (expoente < -expoente_limite) then
        // Underflow, logo prenche-se com zeros
        ponto_flutuante = [sinal zeros(2:bits_expoente + bits_mantissa)]
        decimal = sign(a) * 0
        printf("underflow\n")
    elseif (expoente >= expoente_limite) then
        // Overflow, logo prenche-se com uns
        ponto_flutuante = [sinal ones(2:bits_expoente + bits_mantissa)]
        // Maior decimal possível
        decimal = float2dec(ponto_flutuante, bits_expoente, bits_mantissa)
        printf("overflow\n")
    else
        // parte inteira para baixo do numero |numero|^(quantidade de bits da mantissa - expoente calculado - 1)
        mantissa_decimal = floor((abs(numero)*2^(bits_mantissa - expoente - 1)))
        // mantissa decimal parar binario. Retira-se o primeiro bit da mantissa (ex: 24 bits = 23 bits mais (bit 1))
        mantissa = dec2binario(mantissa_decimal, bits_mantissa);
        // descarta o bit mais significativo
        mantissa = mantissa(2 : bits_mantissa)
        ponto_flutuante = [sinal dec2binario(expoente - (-expoente_limite), bits_expoente) mantissa]
        decimal = float2dec(ponto_flutuante, bits_expoente, bits_mantissa)
    end
endfunction

// Transforma ponto flutuante para decimal
function decimal = float2dec(ponto_flutuante, bits_expoente, bits_mantissa)
    // sinal (primeiro bit), expoente (2 até quantidade de bits do expoente + 1) e mantissa (resto dos bits)
    sinal = ponto_flutuante(1)
    expoente = ponto_flutuante(2:bits_expoente + 1)
    mantissa = ponto_flutuante(bits_expoente + 2:bits_expoente + bits_mantissa)
    // expoente minimo (ex: para 8 bits = -127)
    expoente_minimo = -2^(bits_expoente - 1)
    
    // expoente decimal + expoente minimo - quantidade de bits da mantissa + 1
    expoente_decimal = binario2dec(expoente, bits_expoente) + expoente_minimo + 1 - bits_mantissa
    // (bit extra 1) + bits da mantissa para decimal
    mantissa_decimal = binario2dec([1 mantissa], bits_mantissa)
    decimal = (-1)^sinal * (mantissa_decimal) * 2^(expoente_decimal)
endfunction
