#include <stdio.h>
#include <math.h>

// Metodo responsável pelo cálculo do f'(x)
// Adicione as derivadas aqui
float derivadaFuncao (float x) {
    // 2x - 8
    // return 2*x - 8;

    // 3x^2 - 4
    // return 3 * pow(x, 2.0) - 4;

}

// Método responsável pelo cálculo do f(x)
// Adicione as funções aqui
float imagemFuncao (float x) {
    // x^3 - 4x + 2
    // return pow(x, 3.0) - 4 * x + 2;

    // x^2 - 8x + 6
    // return pow(x, 2.0) - 8 * x - 2;

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

float calculaErro (float a, float b) {
    return (a - b) / a;
}

void newtonRaphson (int interacao, float valor, float ERRO_MAX) {
    float anterior = valor;

    interacao++;

    // Valores jogados na função e sua respectiva derivada
    float finicial = imagemFuncao(valor);
    float fderivado = derivadaFuncao(valor);
    printf("Valor anterior: %.9f, f(inicial): %.9f e f'(inicial): %.9f\n", anterior, finicial, fderivado);

    // Método de Newton-Raphson em sí
    valor -= (finicial/fderivado);

    // Calculo de erro
    float erro = calculaErro(valor, anterior);
    erro < 0 ? erro *= (-1) : erro;
    printf("Erro percentual: %.9f%%\n", erro * 100);

    if (erro > ERRO_MAX) {
        printf("Valor aproximado: %.9f, %d interacao\n\n", valor, interacao);
        newtonRaphson(interacao, valor, ERRO_MAX);
    }
    else {
        printf("Valor aproximado: %.9f, em %d interacoes\n", valor, interacao);
    }
}

int main (int argc, char *argv[]) {
    float valor;
    int interacao = 0;
    const float ERRO_MAX = 1e-6;

    do {
         // Leitura dos limites
        scanf("%f", &valor);

        if (derivadaFuncao(valor) == 0) {
            printf("A derivada deste valor vale 0, logo nao e possivel continuar o programa, digite-o novamente\n");
        }

    } while (derivadaFuncao(valor) == 0);

    // Função recursiva responsável pela resposta
    newtonRaphson(interacao, valor, ERRO_MAX);

    return 0;
}