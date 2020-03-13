#include <stdio.h>
#include <math.h>
#include <stdbool.h>

float mediaSimples (float x1, float x2) {
    return (x1 + x2) / 2;
}

float imagemFuncao (float x) {
    // 4x^5 - 12x^3 - 6x^2 - x - 2
    // return (4 * pow(x, 5.0)) - (12 * pow(x, 4.0)) - (6 * pow(x, 2.0)) - x - 2;

    // x^2 - 8x + 6
    // return pow(x, 2.0) - 8 * x + 6;

    // -x^6 + x^3 -x
    return - pow(x, 6.0) + pow(x, 3.0) - x;
}

int main (int argc, char *argv[]) {
    float limiteA, limiteB;
    float fA, fB;
    float fX, fXAnterior;
    float xMed;
    int interacao = 1;
    int bolzano;
    float erro;
    const float ERRO_MAX = 1e-10;

    // Leitura dos limites
    scanf("%f %f", &limiteA, &limiteB);

    // Valores jogados na função de forma a achar o f(x)
    fA = imagemFuncao(limiteA);
    fB = imagemFuncao(limiteB);

    // Calula valor médio e acha seu f(x)
    xMed = mediaSimples(limiteA, limiteB);
    fX = fXAnterior = imagemFuncao(xMed);
    printf ("xMed: %.9f, fX: %.9f\n", xMed, fX);

    // Teorema de Bolzano
    bolzano = (fA * fX > 0 ? 1:0);
    printf ("Bolzano: %d\n", bolzano);
    switch (bolzano) {
        case 1:
            limiteA = xMed;
            fXAnterior = fA;
            fA = fX;
            erro = (fA - fXAnterior) / fA;
            break;

        case 0:
            limiteB = xMed;
            fXAnterior = fB;
            fB = fX;
            erro = (fB - fXAnterior) / fB;
            break;
    }
    printf("Erro percentual: %.9f\n", erro);
    erro < 0 ? erro *= (-1) : erro;

    printf("[a: %f; b: %f], %d interacao\n\n", limiteA, limiteB, interacao);

    while (erro > ERRO_MAX) {
        interacao++;

        // Calula valor médio e acha seu f(x)
        xMed = mediaSimples(limiteA, limiteB);
        fX = fXAnterior = imagemFuncao(xMed);
        printf ("xMed: %.9f, fX: %.9f\n", xMed, fX);

        // Teorema de Bolzano
        bolzano = (fA * fX > 0 ? 1:0);
        printf ("Bolzano: %d\n", bolzano);
        switch (bolzano) {
            case 1:
                limiteA = xMed;
                fXAnterior = fA;
                fA = fX;
                erro = (fA - fXAnterior) / fA;
                break;

            case 0:
                limiteB = xMed;
                fXAnterior = fB;
                fB = fX;
                erro = (fB - fXAnterior) / fB;

                break;
        }
        printf("Erro percentual: %.9f\n", erro);
        erro < 0 ? erro *= (-1) : erro;

        printf("[a: %.9f; b: %.9f], %d interacao\n\n", limiteA, limiteB, interacao);
    }

    printf("Valor aproximado [a: %.9f; b: %.9f], em %d interacoes", limiteA, limiteB, interacao);

    return 0;
}