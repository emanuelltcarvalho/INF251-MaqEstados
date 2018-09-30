// TP2.2 - INF251 - OC1 - 2018/2
// ALUNO: Emanuell T. Carvalho
// MATRÍCULA: 85244
//
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
//      ::IMPLEMENTAÇÃO BASEADA NO EXEMPLO EM SALA::

module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b0; 
 else 
  q <= data; 
end 
endmodule //End 

module ffr1 ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b1; 
 else 
  q <= data; 
end 
endmodule //End 

// ----   FSM alto nível com Case
module statem(clk, reset,a, s);
input clk, reset,a;
output [2:0] s;
reg [2:0] state;  // 3 bits de estado
parameter zero=3'b010, dois=3'b100, tres=3'b110, quatro=3'b011, cinco=3'b111;

assign s = (state == zero)? 3'b000:
           (state == dois)? 3'b010:
           (state == tres)? 3'b011:
           (state == quatro)? 3'b100: 3'b101;   

always @(posedge clk or negedge reset)
     begin
          if (reset==0)
               state = zero; // arbitrario neste exemplo, nao especificado...
          else
               case (state)
                    zero: state = tres;
                    tres:
                         if ( a == 1 ) state = cinco;
                         else state = dois;
                    dois: state = quatro;
                    quatro:
                         if ( a == 1 ) state = tres;
                         else state = zero;                   
                    cinco: state = dois;
               endcase
     end
endmodule
// FSM com portas logicas
module statePorta(input clk, input res, input d, output [2:0] s);
wire [2:0] e;
wire [2:0] p;                           //_______________________
assign a = d;                           // NÚMERO DE OPERADORES:
assign p[2] = e[1]&(~e[0]|e[2]|a);      //  4
assign p[1] = ~(e[2]&e[1])|a&~e[0];     //  5
assign p[0] = ~e[1]|a&e[2]&~e[0];       //  5
assign s[2] = e[0];                     //  0
assign s[1] = e[2]&~e[0];               //  2
assign s[0] = e[2]&e[1];                //  1
//assign s = e[2:0];                    // TOTAL: 16 operadores
ff e2(p[2], clk, res, e[2]);            //_______________________
ffr1 e1(p[1], clk, res, e[1]);
ff e0(p[0], clk, res, e[0]);
endmodule

module stateMem(input clk,input res, input a, output [2:0] s);
reg [5:0] StateMachine [0:15];
initial
begin  // programar ainda....
//StateMachine[0] = 6'b110000;
StateMachine[2] = 6'b110000;  
StateMachine[3] = 6'b010100;
StateMachine[4] = 6'b011010;  
StateMachine[6] = 6'b100011;
StateMachine[7] = 6'b100101;  
StateMachine[10] = 6'b110000;
StateMachine[11] = 6'b110100;  
StateMachine[12] = 6'b011010;
StateMachine[14] = 6'b111011;  
StateMachine[15] = 6'b100101;
end
wire [3:0] address; // 16 linhas , 4 bits de endereco
wire [5:0] dout;  // 6 bits de largura
assign address[3] = a;
assign dout = StateMachine[address];
assign s = dout[2:0];
ff st0(dout[3],clk,res,address[0]);
ffr1 st1(dout[4],clk,res,address[1]);
ff st2(dout[5],clk,res,address[2]);
endmodule

module main;
reg c,res,a;
wire [2:0] sC;
wire [2:0] sPt;
wire [2:0] sM;
statem FSM(c,res,a,sC);
statePorta FSM2(c,res,a,sPt);
stateMem FSM1(c,res,a,sM);

initial
    c = 1'b0;
  always
    c= #(1) ~c;

// visualizar formas de onda usar gtkwave out.vcd
initial  begin
     $dumpfile ("out.vcd"); 
     $dumpvars; 
   end 

  initial 
    begin
     $monitor($time," c %b res %b a %b sC %d sPt %d sM %d",c,res,a,sC,sPt,sM);
      #1 res=0; a=0;
      #1 res=1;
      #10 a=1; // depois de 5 "clocks", cada clock 2 unidades de tempo
      #10;
      $finish ;
    end
endmodule

