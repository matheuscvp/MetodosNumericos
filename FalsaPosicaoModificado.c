#include <stdio.h>
#include <math.h>

// Semelhança simples de triangulos
float semelhancaTriangulos (float limiteA, float limiteB, float fA, float fB) {
    return ((limiteA * fB) - (limiteB * fA)) / (fB - fA);
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

    // cos(x) - x
    // return cos(x) - x;
}

void falsaPosicao (int interacao, float limiteA, float fA, float limiteB, float fB, float ERRO_MAX, float fXAnterior, int na, int nb) {
    int bolzano;
    float erro;
    float x;
    float fX;

    interacao++;

    printf("fA: %.9f, e fB: %.9f\n", fA, fB);

    // Calcula valor da semelhança de triangulos e acha seu f(x)
    x = semelhancaTriangulos(limiteA, limiteB, fA, fB);
    fX = imagemFuncao(x);
    printf ("x: %.9f, fX: %.9f\n", x, fX);

    // Teorema de Bolzano
    bolzano = (fA * fX > 0 ? 1:0);
    printf ("Bolzano: %d\n", bolzano);
    switch (bolzano) {
        case 1:
            limiteA = x;
            fA = fX;
            na = 0;
            nb += 1;
            if (nb > 2) {
                fB /= 2;
            }
            erro = (limiteA - fXAnterior) / limiteA;
            fXAnterior = limiteA;
            break;

        case 0:
            limiteB = x;
            fB = fX;
            nb = 0;
            na += 1;
            if (na > 2) {
                fA /= 2;
            }
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
        falsaPosicao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX, fXAnterior, na, nb);
    }

    // Se sim, printa o ultimo valor aproximado e o total de interações
    else {
        printf("Valor aproximado [a: %.9f; b: %.9f], em %d interacoes\n", limiteA, limiteB, interacao);
    }
}

int main (int argc, char *argv[]) {
    float limiteA, limiteB;
    float fA, fB;
    int interacao = 0;
    const float ERRO_MAX = 1e-6;

    do {
         // Leitura dos limites
        scanf("%f %f", &limiteA, &limiteB);

        // Valores jogados na função de forma a achar o f(x)
        fA = imagemFuncao(limiteA);
        fB = imagemFuncao(limiteB);

        if ((fA * fB) > 0) {
            printf("Nao existe raiz neste intervalo, digite-os novamente\n");
        }

    } while ((fA * fB) > 0);

    // Função recursiva responsável pela resposta
    falsaPosicao (interacao, limiteA, fA, limiteB, fB, ERRO_MAX, 0, 0, 0);

    return 0;
}