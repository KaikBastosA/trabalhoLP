# Similaridade de Programas com Bag-of-Words

## 1. Objetivo

Implementar em Haskell um programa que compara dois arquivos de codigo fonte usando uma metrica inspirada em Bag-of-Words.

## 2. Ideia Principal

Bag-of-Words representa um texto pela frequencia das palavras, ignorando a ordem em que elas aparecem.

Neste trabalho, a mesma ideia e aplicada a codigo fonte:

- o codigo e quebrado em palavras;
- separadores sao descartados;
- palavras reservadas recebem peso maior;
- as frequencias dos dois programas sao comparadas.

## 3. Entradas

O programa recebe quatro arquivos:

```text
res sep c1 c2
```

- `res`: palavras reservadas da linguagem.
- `sep`: caracteres separadores que devem ser descartados.
- `c1`: primeiro codigo fonte.
- `c2`: segundo codigo fonte.

## 4. Tokenizacao

O arquivo `sep` e interpretado como um conjunto de caracteres literais.

Cada caractere presente em `sep` separa tokens. As sequencias nao vazias entre separadores sao consideradas palavras.

## 5. Pesos

Cada ocorrencia recebe um peso:

- palavra reservada: peso 2;
- demais palavras: peso 1.

Assim, uma palavra reservada que aparece 3 vezes tem frequencia ponderada 6.

## 6. Frequencias

O programa monta duas tabelas de frequencia:

- uma para `c1`;
- outra para `c2`.

O relatorio mostra as frequencias de `c1` em ordem decrescente. Em caso de empate, usa ordenacao lexicografica.

## 7. Regra Dos 10%

Para cada palavra de `c1`, sejam:

- `f1`: frequencia ponderada em `c1`;
- `f2`: frequencia ponderada em `c2`.

A palavra contribui para `m` quando a diferenca entre `f1` e `f2` e de ate 10% de `f1`.

No codigo, a verificacao evita ponto flutuante:

```text
10 * abs(f1 - f2) <= f1
```

## 8. Indice Final

O indice de similaridade e:

```text
m / soma(f1)
```

Quanto mais proximo de 1, mais similares sao os programas segundo essa metrica.

## 9. Exemplo

Compilacao:

```bash
make
```

Execucao:

```bash
./similaridade examples/res.txt examples/sep.txt examples/c1.hs examples/c2.hs
```

Ou:

```bash
make run-example
```

## 10. Complexidade

Se `n` for o numero total de caracteres lidos:

- tokenizacao: O(n);
- contagem com mapas balanceados: O(t log u), em que `t` e o numero de tokens e `u` e o numero de palavras unicas;
- ordenacao do relatorio: O(u log u).

## 11. Limitacoes

- A abordagem ignora a estrutura sintatica do programa.
- Renomeacoes de variaveis podem reduzir a similaridade.
- Comentarios e strings so sao tratados corretamente se os separadores escolhidos forem adequados.
- A metrica considera frequencias, nao a ordem nem a semantica do codigo.

## 12. Possiveis Melhorias

- Remover comentarios antes da tokenizacao.
- Normalizar identificadores.
- Usar analise lexica especifica da linguagem.
- Comparar tambem estruturas sintaticas.
