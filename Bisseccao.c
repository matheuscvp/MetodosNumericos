#include <stdio.h>
#include <math.h>

// Média Simples
float mediaSimples (float x1, float x2) {
    return (x1 + x2) / 2;
}

// Método responsável pelo cálculo do f(x)
// Adicione as funções aqui
float imagemFuncao (float x) {
    // x^2 - 8x + 6
    return pow(x, 2.0) - 8 * x + 6;

    // -x^6 + x^3 -x
    // return - pow(x, 6.0) + pow(x, 3.0) - x;

    // x^3 - x - 2
    // return pow(x, 3.0) - x - 2;

    // -0.6x^2 + 2.4x + 5.5
    // return - 0.6 * pow(x, 2.0) + 2.4 * x + 5.5;

    // x^10 - 1
    // return pow(x, 10.0) - 1;

    // 4x^3 - 6x^2 + 7x - 2.3
    // return 4 * pow(x, 3.0) - 6 * pow(x, 2.0) + 7 * x - 2.3;

}

// Lógica do método da bissecção
void bisseccao (int interacao, float limiteA, float fA, float limiteB, float fB, float ERRO_MAX, float fXAnterior) {
    int bolzano;
    float erro;
    float xMed;
    float fX;

    interacao++;

    // Calcula valor médio e acha seu f(x)
    xMed = mediaSimples(limiteA, limiteB);
    fX = imagemFuncao(xMed);
    printf ("xMed: %.9f, fX: %.9f\n", xMed, fX);

    // Teorema de Bolzano
    bolzano = (fA * fX > 0 ? 1:0);
    printf ("Bolzano: %d\n", bolzano);
    switch (bolzano) {
        case 1:
            limiteA = xMed;
            fA = fX;
            erro = (limiteA - fXAnterior) / limiteA;
            fXAnterior = limiteA;
            break;

        case 0:
            limiteB = xMed;
            fB = fX;
            erro = (limiteB - fXAnterior) / limiteB;
            fXAnterior = limiteB;
            break;
    }

    erro < 0 ? erro *= (-1) : erro;
    printf("Erro percentual: %.9f%% e fXAnterior: %.9f\n", erro * 100, fXAnterior);

    // Checagem pra ver se o erro é próximo a zero
    // Se não, a função se repete recursivamente
    if (erro > ERRO_MAX) {
        printf("[a: %.9f; b: %.9f], %d interacao\n\n", limiteA, limiteB, interacao);
        bisseccao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX, fXAnterior);
    }

    // Se sim, printa o ultimo valor aproximado e o total de interações
    else {
        printf("Valor aproximado [a: %.9f; b: %.9f], em %d interacoes", limiteA, limiteB, interacao);
    }
}

int main (int argc, char *argv[]) {
    float limiteA, limiteB;
    float fA, fB;
    int interacao = 0;
    const float ERRO_MAX = 1e-6;

    // Leitura dos limites
    scanf("%f %f", &limiteA, &limiteB);

    // Valores jogados na função de forma a achar o f(x)
    fA = imagemFuncao(limiteA);
    fB = imagemFuncao(limiteB);

    // Função recursiva responsável pela resposta
    bisseccao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX, 0);

    return 0;
}