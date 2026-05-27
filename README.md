# Trabalho de Linguagens de Programação

Trabalho de LP em Haskell

## Proposta

Objetivo: implementar um algoritmo de similaridade de programas inspirado em Bag-of-Words (BoW).

Descrição: O programa deve ler quatro arquivos de texto (um com as palavras reservadas da linguagem de programação a ser usada, um com caracteres de escape a ignorar e dois com o código fonte a ser comparado), computar a frequência de cada palavra desses arquivos e informar uma métrica de similaridade, conforme descrito a seguir.

Entrada: quatro arquivos de texto

    palavras reservadas da linguagem (res)
    separadores da linguagem a serem descartados (sep)
    arquivo de código 1 (c1)
    arquivo de código 2 (c2)

Saída: um relatório com as frequências decrescentes de cada palavra de c1 (desempate por ordenação lexicográfica) e um valor m que indica a similaridade, conforme as regras a seguir.

Regras:

    O programa deve computar, em c1 e c2, a frequência fi (1 <= i <= 2) de cada palavra que não esteja incluída em sep.
    Palavras contidas em res devem ter o dobro de peso que as demais palavras.
    Para cada frequência de palavra fi computada, se a diferença entre f1 e f2 for de até 10%, m = m + f1.
    O índice de similaridade será m / soma(f1), em que soma(f1) representa a soma de todos os valores computados para f1.

Linguagem de programação:

e) Haskell

Entregáveis:

g) Código fonte

h) Makefile e/ou roteiro completo de compilação/execução

i) Arquivos de exemplos de uso

j) Apresentação do trabalho (a atividade prevê a data-limite para a apresentação, não apenas para a entrega, podendo ocorrer antes).

k) O trabalho pode ser feito individualmente ou em grupos de até cinco pessoas. Não serão aceitas entregas com mais integrantes. Em caso de grupos, deverá ser anexado um relatório que descreva a atuação de cada membro.
