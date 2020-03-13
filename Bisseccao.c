#include <stdio.h>
#include <math.h>
#include <stdbool.h>

// Média Simples
float mediaSimples (float x1, float x2) {
    return (x1 + x2) / 2;
}

// Método responsável pelo cálculo do f(x)
// Adicione as funções aqui
float imagemFuncao (float x) {
    // x^2 - 8x + 6
    // return pow(x, 2.0) - 8 * x + 6;

    // -x^6 + x^3 -x
    // return - pow(x, 6.0) + pow(x, 3.0) - x;
}

// Lógica do método da bissecção
void bisseccao (int interacao, float limiteA, float fA, float limiteB, float fB, float ERRO_MAX) {
    int bolzano;
    float erro;
    float xMed;
    float fX, fXAnterior;

    interacao++;

    // Calula valor médio e acha seu f(x)
    xMed = fXAnterior = mediaSimples(limiteA, limiteB);
    fX = imagemFuncao(xMed);
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

    // Checagem pra ver se o erro é próximo a zero
    // Se não, a função se repete recursivamente
    if (erro > ERRO_MAX) {
        printf("[a: %.9f; b: %.9f], %d interacao\n\n", limiteA, limiteB, interacao);
        bisseccao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX);
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
    const float ERRO_MAX = 1e-10;

    // Leitura dos limites
    scanf("%f %f", &limiteA, &limiteB);

    // Valores jogados na função de forma a achar o f(x)
    fA = imagemFuncao(limiteA);
    fB = imagemFuncao(limiteB);

    // Função recursiva responsável pela resposta
    bisseccao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX);

    return 0;
}