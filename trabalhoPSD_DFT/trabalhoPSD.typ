#import "../typst-ifsc/template/article.typ": article


#show: doc => article(
  title: "Trabalho de DFT",
  subtitle: "Processamento de sinais digitais (PSD029007)",
  // Se apenas um autor colocar , no final para indicar que é um array
  authors:("Rhenzo Hideki Silva Kajikawa",),
  date: "17 de março de 2024",
  doc,
)

= Questão 1
As duas sequências de oitos $x_1 [n]$ e $x_2 [n]$ mostradas na figura a seguir têm DFT's $X_1 [k]$ e $X_2 [k]$, respectivamente. Determine a relação entre $X_1 [k]$ e $X_2[k]$

== Resolução Teórica

- Observando $x_1 [n]$ temos:
$x_1 [n] = 0 delta(n) + a delta(n-1) + b delta(n-2) + c delta(n-3) + d delta(n-4) + e delta(n-5) \ + 0 delta(n-6) +0 delta(n-7) + 0 delta(n-8)$

- Observando $x_2 [n]$ temos:
$x_2 [n] = d delta(n) + e delta(n-1) + 0 delta(n-2) + 0 delta(n-3) + 0 delta(n-4) + a delta(n-5) \ + b delta(n-6) + c delta(n-7) + 0 delta(n-8)$

Observando ambos, podemos desconsiderar o $delta(n-8)$ e considerar a janela de 0 a 7 , sendo assim uma janela de 8 pontos.

Com essas considerações podemos concluir que:

$x[(n-4) mod 8] -> X_2 = e^((-j 2pi)/8 dot 4) dot X_1[k] $   

== Resolução Matlab
```Matlab
%Questão 1
pkg load signal;
close all;
clear all;
clc;

N= 8;
k=0:N-1;
n=0:N-1

%Cria o vetor de impulso dos sinais
x1 = [0,1,2,3,2,1,0,0];
x2 = [2,1,0,0,0,1,2,3];

%Faz a DFT de x1
X = fft(x1);
%Desloca X1 em 4
Y = exp(j*pi*2*4*k/8).*X;

%Faz a inversa
y = ifft(Y);

%Compara o resultado com x2
subplot(211)
stem(n,x2)
title('x_2 (n)')
subplot(212)
stem(n,y)
title('x_1 [(n-4) mod 8]')

```


#figure(
  image("./Figuras/q1.svg",width:100%),
  caption: [
     Resultados da Questão 1 \ Fonte: Elaborada pelo autor
  ],
  supplement: "Figura"
);

#pagebreak()
= Questão 2
Suponha que temos duas sequências de quantro pontos $x[n]$ e $h[n]$, da seguinte foma:

#align(center)[
  $x[n]= cos(pi n / 2)$

  $h[n]=2^n$

  n = 0,1,2,3.
]
\ a) Calcule a DFT de quatro pontos 𝑋[𝑘].
\ b) Calcule a DFT de quatro pontos 𝐻[𝑘].
\ c) Calcule 𝑦[𝑛] = 𝑥[𝑛]④ℎ[𝑛] (realizando a convolução circular diretamente).
\ d) Calcule 𝑦[𝑛] do item (c) multiplicando as DFT’s de 𝑥[𝑛] e ℎ[𝑛] e realizando uma DFT
inversa.

== Resolução Teórica
#set enum(numbering: "a)")
+ 
  $
  \ n = 0 -> cos(0) = 1 
  \ n = 1 -> cos(pi/2) = 0
  \ n = 2 -> cos(pi) = -1
  \ n = 3 -> cos(3/2 pi) = 0
  "logo:"
  x[n] = 1delta[n] - delta[n-2]
  \ X[k] = 1 - e ^(-j (2pi)/4  dot 2k) 
  $
+
  $
  \ n = 0 -> 2⁰ = 1 
  \ n = 1 -> 2¹ = 2
  \ n = 2 -> 2^2 = 4
  \ n = 3 -> 2^3 = 8
  "logo:"
  h[n] = 1delta[n]+2delta[n]+4delta[n]+ 8delta[n-2]
  \ H[k] = 1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 4 dot e ^(-j (2pi)/4  dot 2k)   + 8 dot e ^(-j (2pi)/4  dot 3k) 
  $
+
  $
  "temos:"
  \ x[n]=[1,0,-1,0]
  \ h[n]=[1,2,4,8]
  "Relizando convolução circular com h[-n]: "
  \ h[0]=[1,8,4,2]
  \ h[1]=[2,1,8,4]
  \ h[2]=[4,2,1,8]
  \ h[3]=[8,4,2,1]
  \ "Podemos calcular y[n] agora:"
  \ y[0] = 1 dot 1 + 0 dot 8 + (-1) dot 4 + 0 dot 2 = 1 -4 = -3
  \ y[1] = 1 dot 2 + 0 dot 1 + (-1) dot 8 + 0 dot 4 = 2-8 = -6
  \ y[2] = 1 dot 4 + 0 dot 2 + (-1) dot 1 + 0 dot 8 = 4-1 = 3
  \ y[3] = 1 dot 8 + 0 dot 4 + (-1) dot 2 + 0 dot 1 = 8-2 = 6
  \ y[n] = -3delta[n] - 6delta[n-1] +3delta[n-2]+6delta[n-3]
  $

+
  $
  \ Y[K] = (1- e ^(-j (2pi)/4  dot 2k))(1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 4 dot e ^(-j (2pi)/4  dot 2k)   + 8 dot e ^(-j (2pi)/4  dot 3k) )
  \ 1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 4 dot e ^(-j (2pi)/4  dot 2k)   + 8 dot e ^(-j (2pi)/4  dot 3k) -  e ^(-j (2pi)/4  dot 2k) - 2 dot e ^(-j (2pi)/4  dot 3k)   -4  dot e ^(-j (2pi)/4  dot 4k) -8 dot e ^(-j (2pi)/4  dot 5k) 
  \ 1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 3 dot e ^(-j (2pi)/4  dot 2k)   + 6 dot e ^(-j (2pi)/4  dot 3k) -4  dot e ^(-j (2pi)/4  dot 4k) -8 dot e ^(-j (2pi)/4  dot 5k)
  \ "temos um deslocamento de 4 e de 5 porém está sendo trabalho em apenas uma faixa de 4"
  \ 1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 3 dot e ^(-j (2pi)/4  dot 2k)   + 6 dot e ^(-j (2pi)/4  dot 3k) -4  dot e ^(-j (2pi)/4  dot (4 - 4)k) -8 dot e ^(-j (2pi)/4  dot (5 - 4 )k)
  \ 1+ 2 dot e ^(-j (2pi)/4  dot 1k) + 3 dot e ^(-j (2pi)/4  dot 2k)   + 6 dot e ^(-j (2pi)/4  dot 3k) -4  dot e ^(-j (2pi)/4  dot (0)k) -8 dot e ^(-j (2pi)/4  dot (1)k)
  \ Y[k] = -3 - 6 dot e ^(-j (2pi)/4  dot 1k) + 3 dot e ^(-j (2pi)/4  dot 2k)   + 6 dot e ^(-j (2pi)/4  dot 3k)
  \ y[n] = -3delta[n]-6delta[n-1]+3delta[n-2]+6delta[n-3]
  $

== Resolução Matlab
```Matlab
%Questão 2
pkg load signal;
close all;
clear all;
clc;

N= 4;
k=0:N-1;
n=0:N-1;

%criando sinais
x = [1,0,-1,0]
h = [1,2,4,8]

X = fft(x);
H = fft(h);

%conv pela DFT
convDFT = ifft(X.*H)

%conv utilizando cconv
convDIR = cconv(x,h,4)

%plotando os sinais e comparando
subplot(211)
stem(n,convDFT);
title('Convolução pela DFT')
subplot(212)
stem(n,convDIR)
title('Convolução Dirata')
```


#figure(
  image("./Figuras/q2.svg",width:100%),
  caption: [
     Resultados da Questão 2 \ Fonte: Elaborada pelo autor
  ],
  supplement: "Figura"
);
  
#pagebreak()

= questão 3
Dois sinais de comprimento finito, $x_1 [n]$ e $x_2 [n]$, são esboçados na figura a seguir. Suponha que $x_1 [n]$ e $x_2 [n]$ sejam nulos fora da região mostrada na figura. Seja $x_3 [n]$ a convolução circular de oito pontos de $x_1 [n]$ com $x_2[n]$. Determine $x_3[n]$

== Resolução Teórica

- Os sinais dados tem a seguinte sequências:
$
x_1 [n] = [1,2,1,1,2,1,1,2]
x_2 [n] = [0,1,3,2,0,0,0,0]
$
- Realizando a inversão temporal em $x_2 [n]$:
$
\ x_2 [0] = [0,0,0,0,0,2,3,1]
\ x_2 [1] = [1,0,0,0,0,0,2,3]
\ x_2 [2] = [3,1,0,0,0,0,0,2]
\ x_2 [3] = [2,3,1,0,0,0,0,0]
\ x_2 [4] = [0,2,3,1,0,0,0,0]
\ x_2 [5] = [0,0,2,3,1,0,0,0]
\ x_2 [6] = [0,0,0,2,3,1,0,0]
\ x_2 [7] = [0,0,0,0,2,3,1,0]
$

- Calculando $x_3[n]$:
$
\ x_3 [0] = 1 dot 0 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 0 + 1 dot 2 + 1dot 3 + 2 dot 1 = 7
\ x_3 [1] = 1 dot 1 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 0 + 1 dot 0 + 1dot 2 + 2 dot 3 = 9
\ x_3 [2] = 1 dot 3 + 2 dot 1 + 1 dot 0 + 1dot 0 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 2 = 9
\ x_3 [3] = 1 dot 2 + 2 dot 3 + 1 dot 1 + 1dot 0 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 0 = 9
\ x_3 [4] = 1 dot 0 + 2 dot 2 + 1 dot 3 + 1dot 1 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 0 = 8
\ x_3 [5] = 1 dot 0 + 2 dot 0 + 1 dot 2 + 1dot 3 + 2 dot 1 + 1 dot 0 + 1dot 0 + 2 dot 0 = 7
\ x_3 [6] = 1 dot 0 + 2 dot 0 + 1 dot 0 + 1dot 2 + 2 dot 3 + 1 dot 1 + 1dot 0 + 2 dot 0 = 9
\ x_3 [7] = 1 dot 0 + 2 dot 0 + 1 dot 0 + 1dot 0 + 2 dot 2 + 1 dot 3 + 1dot 1 + 2 dot 0 = 8
$

Temos que, $x_3 [2] = 9$

== Resolução Matlab
```Matlab
%questão 3
pkg load signal;
close all;
clear all;
clc;

N= 8;
k=0:N-1;
n=0:N-1;

%criando os sinais
x1 = [1,2,1,1,2,1,1,2]
x2 = [0,1,3,2,0,0,0,0]

%Fazendo a convolução de 8
x3 = cconv(x1,x2,8)

%Plotando o sinal
stem(n,x3)
ylim([0 9]);

%Valor de x3[2] = 9
```


#figure(
  image("./Figuras/q3.svg",width:100%),
  caption: [
     Resultados da Questão 2 \ Fonte: Elaborada pelo autor
  ],
  supplement: "Figura"
);

#pagebreak()
= Questão 4
Na figura é mostrada uma sequência de tempo discreto com seis pontos $x[n]$. Suponha que $x[n] = 0$ fora do intervalo mostrado. O valor de $x[4]$ nãp ´e conhecido e é representado como  b. Observe que a amostra mostrada como b na figura não está necessariamente na escala. Sejam $X(e^(j omega))$ a TFTD de $x[n]$ e $X_1 [k]$ as amostras de $X(e^(j omega))$ a cada $pi/2$, isto é.

#align(center)[
  $X_1 [k] = X(e^(j omega)) |_(omega = (k pi)/2),0<= k <= 3$
]
A sequência com quatros pontos $x_1 [n]$ que resulta da invesa com quatro pontos de $X_1 [k]$ é mostrada a seguir. Com base nessa figura, você pode determinar b de modo único? Caso afirmativo,dê esse valor de b.

  Resolução:

sendo $x[n] = delta[n] + 2delta[n-2] + 2delta[n-3] + b delta[n-4] + delta[n-5]$ 

e a DFT de $X[e^(j (2 k pi)/4)] = e^(j (2 k pi)/4) + 2 e^(j (2 k pi)/4 2) + e^(j (2 k pi)/4 3)+b e^(j (2 k pi)/4 4) + e^(j (2 k pi)/4 5)$

\ $X[e^(j (2 k pi)/4)] = e^(j (2 k pi)/4) + 2 e^(j (2 k pi)/4 2) + 2e^(j (2 k pi)/4 3)+b e^(j (2 k pi)/4 4) + e^(j (2 k pi)/4 5) $


\ $X[e^(j (2 k pi)/4)] = 1 + 2 e^(j (2 k pi)/4 2) + 2e^(j (2 k pi)/4 3)+b e^(j (2 k pi)/4 0) + e^(j (2 k pi)/4) $

\ $X[e^(j (2 k pi)/4)] = 1 + 2 e^(j (2 k pi)/4 2) + 2e^(j (2 k pi)/4 3)+b + e^(j (2 k pi)/4) $

Sendo
$x[n] = 4delta[n] + delta[n-1] + 2delta[n-2] + 2 delta[n-3]$ 

Fazendo a DTF de X_1[k]
\ $X_1 [e^(j (2 k pi)/4)] = 4 + e^(j (2 k pi)/4) + 2e^(j (2 k pi)/4 2)+ 2e^(j (2 k pi)/4 3) $

Substituindo em $X_1 [k] = X[e^(j (2 k pi)/4)]|_(omega = k pi/2) $

\ $ X_1 [k] = X[e^(j omega)] ->  1 + 2 e^(j (2 k pi)/4 2) + 2e^(j (2 k pi)/4 3)+b + e^(j (2 k pi)/4) = 4 + e^(j (2 k pi)/4) + 2e^(j (2 k pi)/4 2)+ 2e^(j (2 k pi)/4 3)
\  1 + b = 4
\ b = 4 - 1 = 3
\ b = 3
$

#pagebreak()
= Questão 5
Na figura a seguir são mostradas duas sequências de comprimento finito $x_1 [n]$ e $x_2 [n]$. Qual é o menor N tal que a convolução circular de N pontos de $x_1 [n]$ e $x_2 [n]$ seja igual à uma convolução linear dessas sequências.

== Resolução Teórica

  - Dada as figuras, obtém-se os seguintes pontos:
$
\ x_1 [n] = [1,-2.-1.3.0.0]
\ x_2 [n] = [0,2,0,0,-1,1]
$
Para que as covoluções tenham a mesma sequência
$
\ x_1 [n] = [1,-2.-1.3.0.0] -> N_1 = 4
\ x_2 [n] = [0,2,0,0,-1,1] -> N_2 = 6
\ N = N_1 + N_2 - 1 = 4 + 6 - 1 = 9
$

== Resolução Matlab
```Matlab
%questão 5
pkg load signal;
close all;
clear all;
clc;

N= 9;
k=0:N-1;
n=0:N-1;

%Cria o sinal com tamanho 9 para conv circular
x1 = [1,-2,-1,3,0,0,0,0,0]
x2 = [0,2,0,0,-1,1,0,0,0]
cc = cconv(x1,x2,9);

%Ajusta os sinais para os tamanhos originais
%Faz a convolução linear
x1 = [1,-2,-1,3]
x2 = [0,2,0,0,-1,1]
cl = conv(x1,x2);

%Compara os resultados das convoluções linear e circular
subplot(211)
stem(n,cc);
title('Convolução circular');
subplot(212)
stem(n,cl);
title('Convolução Linear');
```


#figure(
  image("./Figuras/q5.svg",width:100%),
  caption: [
     Resultados da Questão 2 \ Fonte: Elaborada pelo autor
  ],
  supplement: "Figura"
);



#pagebreak()
= Questão 6
Na figura a seguir é mostrada ua sequência $x[n]$ para a qual o valor de $x[3]$ é uma constante desconhecida c.

O valor da amostra com amplitude c não está necessariamente representada na escada. Considere:

$X_1 [k] = X[k] e^(j 2pi/3 3k) $

Sendo $X[k]$ a DFT de cinco pontos de $x[n]$. A sequência $x_1 [n]$ é a DFT inversa de $X_1 [k]$. Qual o valor de c?

multiplicando ambos os lados por $e^(-j 2pi/5 3k)$

$e^(-j 2pi/5 3k) X_1[k] = X[k] $

Sendo $X_1 [n]$
$\ x_1[n] = 2 delta[n] + delta[n-1] + 2delta[n-2] - delta[n-3] + 0delta[n-4]$

Sendo $x[n]$
$ \ x[n] = 2delta[n] - delta[n-1] + 0delta[n-2] + c delta[n-3] + delta[n-4]$


Calculando:

$
\  X[k] = X_1[k] dot e^(-j 2pi/5 3k)
\ x_1[n] = x[(n-2) mod 5] -> \ x_1[(n-3) mod 5] = 2 delta[(n-2) mod 5] - delta[(n-3) mod 5] \ + 0delta[(n-4) mod 5] - c delta[(n-5) mod 5] + delta[(n-6) mod 5]
\ x_1[(n-3) mod 5] = 2 delta[n-2] - delta[n-3] \ + 0delta[n-4] - c delta[n] + delta[n-1]
\ x_1[n] = 2 delta[n] + delta[n-1] + 2delta[n-2] - delta[n-3] + 0delta[n-4]
 = 2 delta[n-2] - delta[n-3] \ + 0delta[n-4] - c delta[n] + delta[n-1]
 c =2
$

#pagebreak()
= Questão 7

Suponha que tenhamos uma sequência de 1025 pontos de dados ( 1 a mais do que $N = 2^(10)$). Em vez de descartar o valor final, vamos preencher a sequência com zeros até ser comprimento seja $N = 2^(11)$, de modo que possamos usar um algoritmo FFT de raiz 2
+ Quantas multiplicações complexas são necessárias para se computar a DFT usando um algoritmo de FFT raiz 2?
+ Quantas multiplicações complexas seriam necessárias para se computar diretamente a DFT de 1025?

== Resultados teóricos

$
\ N = 2^(11) = 2048 ; N 

$
+ $
  (N/2)log_2(N) -> (1025/2)log_2(1025) = 5215.72
  $

+ $
  
  N^2 -> 1025^2 = 1050625
  $

= Quetão 8
Considere a sequência de comprimento finito real $x[n]$ mosrada na Figura a seguir
+ Esboce a sequência de comprimento finito $y[n]$ cuja DFT de seis pontos seja
\ $ Y[k] = W_6 ^(5k) X[k] $
\ sendo $X[k]$ a DFT de seis pontos de x[n]
+ Esboce a seq7 de comprimento finito $w[n]$ cuja DFt de seis pontos seja
\ $ W[k] = Im{X[k]} $
+ Esboce a sequência de comprimento finito $q[n]$ cuja DFT de três pontos seja
\ $ Q[k] = X[2k +1], k = 0,1,2 $