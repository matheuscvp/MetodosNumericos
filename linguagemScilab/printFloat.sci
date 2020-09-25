function printFloat(ponto_flutuante, bits_expoente, bits_mantissa, bit_extra)
    printf("[%1d] [", ponto_flutuante(1))
    for (i = 2: bits_expoente + 1) printf("%1d", ponto_flutuante(i)) end
    printf("] [%1d] [", bit_extra)    
    for (i = bits_expoente + 2: bits_expoente + bits_mantissa) printf("%1d", ponto_flutuante(i)) end
    printf("]\n")
endfunction
