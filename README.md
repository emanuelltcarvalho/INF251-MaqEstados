# INF251-OC1-2018/2
TP2 de INF 251 - Organização de Computadores I

// TP2 - INF251 - OC1 - 2018/2
// ALUNO: Emanuell T. Carvalho
// MATRÍCULA: 85244

2) Suponha uma entrada A de 1 bit e uma saída S de 3 bits. Se A=0, a saída gera o ciclo 0,3,2,4 → 0,3,2,4 …. Se A=1, a saída gera o ciclo 4,3,5,2 → 4,3,5,2,.... 
Usar a seguinte codificação em função da sua matricula. Primeiro converter em Octal sua matricula = 82322 decimal = 240622 octal. Suponha que sua máquina tenha os estados 0,2,3,4 e 5. Então o código de estado 0 será 2, o codigo do estado 2 será 4, o codigo do estado 3 será  0, o código do estado 4 será 6 e como o código do estado 5 não pode ser 2 (próximo na sequencia de matricula), incrementar para 3.  Voce deve entregar a três implementações no mesmo código, com estados e case, com memória e com portas lógicas. Medir quantos operadores AND, OR, NOT terão as equações para próximo estado e saídas. Por exemplo,  S1 = a & b | ! c. Esta equação tem 3 operadores. S2 =a & b &  ! c | b & !a, terá 6 operadores, S1 e S2 seriam 9 operadores. Medir o total gasto para todas as equações.

//
//  Códigos dos Estados:
//  Decimal	    Octal
//  85244	    2463746
//  	
//  ESTADO	CÓDIGO
//    0	      2
//    2 	  4
//    3	      6
//    4	      3
//    5	      7
//
//      	::MEMÓRIA::									
//  	ENTRADA|  ESTADO   |  PRÓXIMO  |  SAÍDA		
//  LINHA	A	E2	E1	E0	P2	P1	P0	S2	S1	S0
//    0	    0	0	0	0	X	X	X	X	X	X
//    1	    0	0	0	1	X	X	X	X	X	X
//    2	    0	0	1	0	1	1	0	0	0	0
//    3	    0	0	1	1	0	1	0	1	0	0
//    4	    0	1	0	0	0	1	1	0	1	0
//    5	    0	1	0	1	X	X	X	X	X	X
//    6	    0	1	1	0	1	0	0	0	1	1
//    7	    0	1	1	1	1	0	0	1	0	1
//    8	    1	0	0	0	X	X	X	X	X	X
//    9	    1	0	0	1	X	X	X	X	X	X
//   10	    1	0	1	0	1	1	0	0	0	0
//   11	    1	0	1	1	1	1	0	1	0	0
//   12	    1	1	0	0	0	1	1	0	1	0
//   13	    1	1	0	1	X	X	X	X	X	X
//   14	    1	1	1	0	1	1	1	0	1	1
//   15	    1	1	1	1	1	0	0	1	0	1
//
//      ::DIAGRAMA DA IMPLEMENTAÇÃO::
//
//                             +---------------+
//                       A+----+               |
//               E2            |               |
//              +--------------+               |
//         E1   |              |    MEMÓRIA    |
//        +--------------------+               |
//   E0   |     |              |               |
//  +-------------------------->               |
//  |     |     |              +-+-+-+-+-+-+---+
//  |     |     |                | | | | | |
//  |     |     |      +-----+   | | | | | |
//  |     |     |      |     <---+ | | | | +----->S0
//  |     |     +------+ FF2 |     | | | |
//  |     |            |    <+     | | | +------->S1
//  |     |            +-----+     | | |
//  |     |                        | | +--------->S2
//  |     |            +-----+     | |
//  |     |            |     <-----+ |
//  |     +------------+ FF1 |       |
//  |                  |    <+       |
//  |                  +-----+       |
//  |                                |
//  |                  +-----+       |
//  |                  |     <-------+
//  +------------------+ FF0 |
//                     |    <+
//                     +-----+
//
//
//
//      ::DIAGRAMA DE ESTADOS::
//
//                                                0,1
//                              +-----------------------+
//                              |                       |
//                              |      0                |
//    +-------------------------------------+           |
//    |                         |           |           |
//  +-v-+        +---+        +-v-+       +-+-+       +-+-+
//  |   |        |   |        |   |       |   |       |   |
//  | 0 +--------> 3 +--------> 2 +-------> 4 |       | 5 |
//  |   |  0,1   |   |   0    |   |  0,1  |   |       |   |
//  +---+        +-+-+        +---+       +---+       +-^-+
//                 |                                    |
//                 +------------------------------------+
//                      1
//
//
//
