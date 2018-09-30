// TP2.1 - INF251 - OC1 - 2018/2
// ALUNO: Emanuell T. Carvalho
// MATRÍCULA: 85244
//
//	                ::MEMÓRIA::						
//	ESTADO			ENTRADA		SAÍDA			PRÓXIMO		
//  LINHA	E2	E1	E0	A1	A0	S2	S1	S0	P2	P1	P0
//    0	  0	  0	  0	  0	  0	  0	  0	  0	  0	  0	  1
//    1	  0	  0	  0	  0	  1	  0	  0	  0	  0	  0	  1
//    2	  0	  0	  0	  1	  0	  0	  0	  0	  0	  0	  1
//    3	  0	  0	  0	  1	  1	  0	  0	  0	  0	  0	  1
//    4	  0	  0	  1	  0	  0	  0	  0	  1	  0	  1	  0
//    5	  0	  0	  1	  0	  1	  0	  0	  1	  0	  1	  0
//    6	  0	  0	  1	  1	  0	  0	  0	  1	  0	  1	  1
//    7	  0	  0	  1	  1	  1	  0	  0	  1	  0	  1	  1
//    8	  0 	1	  0	  0	  0	  0	  1	  0	  0	  0	  0
//    9	  0	  1	  0	  0	  1	  0	  1	  0	  1	  0	  0
//    10  0	  1	  0	  1	  0	  0	  1	  0	  1	  1	  1
//    11	0	  1	  0	  1	  1	  0	  1	  0	  1	  1	  1
//    12	0	  1	  1	  0	  0	  0	  1	  1	  0	  1	  0
//    13	0	  1	  1	  0	  1	  0	  1	  1	  0	  1	  0
//    14	0	  1	  1	  1	  0	  0	  1	  1	  0	  1	  0
//    15	0	  1	  1	  1	  1	  0	  1	  1	  1	  0	  1
//    16	1	  0	  0	  0	  0	  1	  0	  0	  0	  1	  1
//    17	1	  0	  0	  0	  1	  1	  0	  0	  0	  1	  1
//    18	1	  0	  0	  1	  0	  1	  0	  0	  0	  1	  1
//    19	1	  0	  0	  1	  1	  1	  0	  0	  0	  1	  1
//    20	1	  0	  1	  0	  0	  1	  0	  1	  1	  1	  0
//    21	1	  0	  1	  0	  1	  1	  0	  1	  1	  1	  0
//    22	1	  0	  1	  1	  0	  1	  0	  1	  1	  1	  0
//    23	1	  0	  1	  1	  1	  1	  0	  1	  1	  1	  0
//    24	1	  1	  0	  0	  0	  1	  1	  0	  0	  1	  1
//    25	1	  1	  0	  0	  1	  1	  1	  0	  0	  1	  1
//    26	1	  1	  0	  1	  0	  1	  1	  0	  0	  1	  1
//    27	1	  1	  0	  1	  1	  1	  1	  0	  0	  1	  1
//    28	1	  1	  1	  0	  0	  0	  1	  1	  0	  0	  1
//    29	1	  1	  1	  0	  1	  0	  1	  1	  0	  0	  1
//    30	1	  1	  1	  1	  0	  0	  1	  1	  0	  0	  1
//    31	1	  1	  1	  1	  1	  0	  1	  1	  0	  0	  1
//
//
//
//       ::DIAGRAMA DE ESTADOS::
//    ESTADO  CÓDIGO
//      0       000
//      1       001
//      2       010
//      3       011
//      4       100
//      5       101
//      6       110
//      3       111
//
//                                   0,1,2,3  +---+
//                    +-----------------------+   |
//                    |                       | 3 |
//    +--------------------------+ +---------->   |
//    |               |       0  | |  2,3     +---+
//    |               |          | |                              0,1,2,3
//    |               |          | |            +-------------------------+
//    |               |          | |            |                         |
//  +-v-+           +-v-+       ++-++         +-v-+     +---+           +-+-+
//  |   |           |   |       |   |         |   |     |   |           |   |
//  | 0 +-----------> 1 +-------> 2 <---------+ 3 +-----> 5 +-----------> 6 |
//  |   |  0,1,2,3  |   |  0,1  |   |  0,1,2  |   |  3  |   |  0,1,2,3  |   |
//  +---+           +-+-+       +-+-+         +^-^+     +---+           +---+
//                    |           |            | |
//                    |           |1           | |
//                    |           |            | |
//                 2,3|         +-v-+          | |
//                    |         |   |  0,1,2,3 | |
//                    |         | 4 +----------+ |
//                    |         |   |            |
//                    |         +---+            |
//                    |                          |
//                    +--------------------------+
//  
//
//
//
//      ::IMPLEMENTAÇÃO BASEADA NO EXEMPLO EM SALA::

module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 //   $display("data %b ", data);
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
module statem(clk, reset, a, s);
input clk, reset;
input [1:0] a;
output [2:0] s;
reg [2:0] state;  // 3 bits de estado
parameter zero=3'b000, 
            um=3'b001, 
            dois=3'b010, 
            tres=3'b011, 
            quatro=3'b100, 
            cinco=3'b101, 
            seis=3'b110, 
            tresx=3'b111;

assign s = (state == zero)? 3'b000:
            (state == um)? 3'b001:
           (state == dois)? 3'b010:
           (state == tres)? 3'b011:
           (state == quatro)? 3'b100: 
           (state == cinco)? 3'b101:
            (state == seis)? 3'b110: 3'b011;   

always @(posedge clk or negedge reset)
     begin
          if (reset==0)
               state = zero; // arbitrario neste exemplo, nao especificado...
          else
               case (state)
                    zero: state = um;
                    um: if(a==2'b00 || a==2'b01) state = dois;
                        else state = tres;
                    dois: if(a==2'b00) state = zero;
                        else if(a==2'b01) state = quatro;
                        else state = tresx;
                    tres: if(a==2'b11) state = cinco;
                         else state = dois;
                    quatro: state = tres;              
                    cinco: state = seis;
                    seis: state = tres;
                    tresx: state = um;
               endcase
     end
endmodule
// FSM com portas logicas
module statePorta(input clk, input res, input [1:0] a, output [2:0] s);
wire [2:0] e;
wire [2:0] p;
assign s[2] = e[2]&~(e[1]&e[0]);//e[2]&~e[1]|e[2]&~e[0];
assign s[1] = e[1];
assign s[0] = e[0];
assign p[2] = ~e[2]&e[1]&(~e[0]&(a[1]|a[0])|a[1]&a[0])|e[2]&~e[1]&e[0]; //e[2]&~e[1]&e[0]|~e[2]&e[1]&~e[0]&a[0]|~e[2]&e[1]&~e[0]&a[1]|~e[2]&e[1]&a[1]&a[0];
assign p[1] = e[0]&(~e[2]&~(a[1]&a[0])|~e[1])|~e[0]&(e[2]|e[1]&a[1]); //~e[1]&e[0]|e[2]&~e[0]|~e[2]&e[0]&~a[1]|~e[2]&e[0]&~a[0]|e[1]&~e[0]&a[1];
assign p[0] = ~(e[1]|e[0])|a[1]&~(e[0]&(e[2]|e[1]))|e[2]&e[1]|~e[2]&a[1]&a[0]; //~e[1]&~e[0]|~e[0]&a[1]|e[2]&e[1]|~e[2]&~e[1]&a[1]|~e[2]&a[1]&a[0];
ff e2(p[2], clk, res, e[2]);
ff e1(p[1], clk, res, e[1]);
ff e0(p[0], clk, res, e[0]);
endmodule


module stateMem(input clk,input res, input [1:0] a, output [2:0] s);
reg [5:0] StateMachine [0:31];
initial
begin
    StateMachine[0] = 6'b000001;
    StateMachine[1] = 6'b000001;
    StateMachine[2] = 6'b000001;  
    StateMachine[3] = 6'b000001;
    StateMachine[4] = 6'b001010;
    StateMachine[5] = 6'b001010;
    StateMachine[6] = 6'b001011;
    StateMachine[7] = 6'b001011;
    StateMachine[8] = 6'b010000;
    StateMachine[9] = 6'b010100;
    StateMachine[10] = 6'b010111;
    StateMachine[11] = 6'b010111;  
    StateMachine[12] = 6'b011010;
    StateMachine[13] = 6'b011010;
    StateMachine[14] = 6'b011010;  
    StateMachine[15] = 6'b011101;
    StateMachine[16] = 6'b100011;
    StateMachine[17] = 6'b100011;
    StateMachine[18] = 6'b100011;
    StateMachine[19] = 6'b100011;
    StateMachine[20] = 6'b101110;
    StateMachine[21] = 6'b101110;
    StateMachine[22] = 6'b101110;
    StateMachine[23] = 6'b101110;
    StateMachine[24] = 6'b110011;
    StateMachine[25] = 6'b110011;
    StateMachine[26] = 6'b110011;
    StateMachine[27] = 6'b110011;
    StateMachine[28] = 6'b011001;
    StateMachine[29] = 6'b011001;
    StateMachine[30] = 6'b011001;
    StateMachine[31] = 6'b011001;
end
wire [4:0] address; // 16 linhas , 4 bits de endereco
wire [5:0] dout;  // 6 bits de largura
assign address[0] = a[0];
assign address[1] = a[1];
assign dout = StateMachine[address];
assign s = dout[5:3];
ff st2(dout[2],clk,res,address[4]);
ff st1(dout[1],clk,res,address[3]);
ff st0(dout[0],clk,res,address[2]);
endmodule

module main;
reg c,res;
reg [1:0] a;
wire [2:0] sC;
wire [2:0] sPt;
wire [2:0] sM;
statem FSM(c,res,{a[1],a[0]},sC);       //case
stateMem FSM1(c,res,{a[1],a[0]},sM);
statePorta FSM2(c,res,{a[1],a[0]},sPt);

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
     $monitor($time," c %b res %b a %d sC %d sM %d sPt %d",c,res, a, sC,sM,sPt);
      #1 res=0; a = 2'b00;
      #1 res=1;
      #2 a = 2'b01; // Matrícula: 85244 => a = 01 01 00 11 00 11 11 11 00
      #2 a = 2'b01;
      #2 a = 2'b00;
      #2 a = 2'b11;
      #2 a = 2'b00;
      #2 a = 2'b11;
      #2 a = 2'b11;
      #2 a = 2'b11;
      #2 a = 2'b00;
      
      $finish ;
    end
endmodule
