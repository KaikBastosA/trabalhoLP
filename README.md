# Similaridade BoW de Programas

Implementacao em Haskell de uma metrica simples de similaridade entre dois arquivos de codigo fonte, inspirada em Bag-of-Words.

O programa le quatro arquivos:

1. palavras reservadas da linguagem (`res`);
2. separadores a descartar (`sep`);
3. codigo fonte 1 (`c1`);
4. codigo fonte 2 (`c2`).

Depois imprime as frequencias ponderadas das palavras de `c1` e o indice de similaridade entre `c1` e `c2`.

## Requisitos

- GHC
- Make

Este projeto nao instala dependencias automaticamente e nao executa atualizacoes globais do sistema. No ambiente atual foi encontrado `make`, mas nao foi encontrado `ghc`.

## Compilacao

Em uma maquina com GHC instalado:

```bash
make
```

Isso gera o executavel:

```bash
./similaridade
```

## Execucao

```bash
./similaridade <res> <sep> <c1> <c2>
```

Exemplo:

```bash
./similaridade examples/res.txt examples/sep.txt examples/c1.hs examples/c2.hs
```

Tambem e possivel rodar:

```bash
make run-example
```

## Teste Do Exemplo

```bash
make test
```

O alvo `test` executa o exemplo e compara a saida com `examples/expected.txt`.

## Regras Implementadas

- O arquivo `sep` e interpretado como um conjunto de caracteres literais.
- Cada caractere presente em `sep` e tratado como delimitador.
- Espacos e quebras de linha so separam palavras se estiverem presentes em `sep`.
- O arquivo `res` e lido como uma lista de palavras separadas por whitespace.
- Palavras reservadas tem peso 2.
- Demais palavras tem peso 1.
- As frequencias exibidas sao ponderadas.
- A ordenacao das frequencias de `c1` e decrescente por frequencia, com desempate lexicografico.

Para cada palavra presente em `c1`, o programa compara `f1` e `f2`. A palavra contribui para `m` quando:

```text
10 * abs(f1 - f2) <= f1
```

O indice final e:

```text
m / soma(f1)
```

Se `c1` nao tiver palavras, a similaridade impressa sera `0.0000`.

## Formato Da Saida

```text
Frequencias de c1:
<palavra> <frequencia>
...

m: <valor>
soma(f1): <valor>
similaridade: <valor com 4 casas decimais>
```
