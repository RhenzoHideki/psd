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

Resolução:

- Observando $x_1 [n]$ temos:
$x_1 [n] = 0 delta(n) + a delta(n-1) + b delta(n-2) + c delta(n-3) + d delta(n-4) + e delta(n-5) \ + 0 delta(n-6) +0 delta(n-7) + 0 delta(n-8)$

- Observando $x_2 [n]$ temos:
$x_2 [n] = d delta(n) + e delta(n-1) + 0 delta(n-2) + 0 delta(n-3) + 0 delta(n-4) + a delta(n-5) \ + b delta(n-6) + c delta(n-7) + 0 delta(n-8)$

Observando ambos, podemos desconsiderar o $delta(n-8)$ e considerar a janela de 0 a 7 , sendo assim uma janela de 8 pontos.

Com essas considerações podemos concluir que:

$x[(n-4) mod 8] -> X_2 = e^((-j 2pi)/8 dot 4) dot X_1[k] $   

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

Resolução:
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
  
#pagebreak()

= questão 3
Dois sinais de comprimento finito, $x_1 [n]$ e $x_2 [n]$, são esboçados na figura a seguir. Suponha que $x_1 [n]$ e $x_2 [n]$ sejam nulos fora da região mostrada na figura. Seja $x_3 [n]$ a convolução circular de oito pontos de $x_1 [n]$ com $x_2[n]$. Determine $x_3[n]$

Resolução:

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

  Resolução

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


#pagebreak()
= Questão 6
Na figura a seguir é mostrada ua sequência $x[n]$ para a qual o valor de $x[3]$ é uma constante desconhecida c.

O valor da amostra com amplitude c não está necessariamente representada na escada. Considere:

$X_1 [k] = X[k] e^(j 2pi/3 3k) $

Sendo $X[k]$ a DFT de cinco pontos de $x[n]$. A sequência $x_1 [n]$ é a DFT inversa de $X_1 [k]$. Qual o valor de c?

multiplicando ambos os lados por $e^(-j 2pi/5 3k)$

$e^(-j 2pi/5 3k) X_1[k] = X[k] $

Sendo $X_1 [n]$
$\ x_1[n] = 2 delta[n] + delta[n-1] + 2delta[n-2] - delta[n-3]$

\
Fazendo a DFT de $ X_1[k]$
$ \ X_1[k]=2e^(-j 2pi/5 0k) + e^(-j 2pi/5 1k)+ 2 e^(-j 2pi/5 2k) - e^(-j 2pi/5 3k)
\ X_1[k]=2 + e^(-j 2pi/5 1k)+ 2 e^(-j 2pi/5 2k) - e^(-j 2pi/5 3k)
$

Sendo $x[n]$
$ \ x[n] = 2delta[n] - delta[n-1]+c delta[n-3] + delta[n-4]$

Fazendo a DFT de $ X[k]$
$
\ X_1[k]=2 - e^(-j 2pi/5 1k)+ c e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k)

$

Calculando:

$
\ e^(-j 2pi/5 3k) X_1[k] = X[k]
\ 2 - e^(-j 2pi/5 1k)+ c e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k) =  e^(-j 2pi/5 3k)(2 + e^(-j 2pi/5 1k)+ 2 e^(-j 2pi/5 2k) - e^(-j 2pi/5 3k) )
\ 2 - e^(-j 2pi/5 1k)+ c e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k) =  2e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k)+ 2 e^(-j 2pi/5 5k) - e^(-j 2pi/5 6k)
\ 2 - e^(-j 2pi/5 1k)+ c e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k) =  2e^(-j 2pi/5 3k) + e^(-j 2pi/5 4k)+ 2 - e^(-j 2pi/5 1k)
\ c e^(-j 2pi/5 3k) =  2e^(-j 2pi/5 3k)
\ c = 2
$