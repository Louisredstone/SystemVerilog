`timescale 1ns/1ps

module adder4(
    input [3:0] A,
    input [3:0] B,
    input Ci,
    output [3:0] S,
    output Co,
    output Go,
    output Po
);
wire [3:0] G;
wire [3:0] P;
assign P=A^B;
assign G=A&B;
wire [4:0] C;
assign C[0]=Ci;
assign Co=C[4];
assign S=P^C[3:0];

wire P0C0;
wire P1P0C0;
wire P2P1P0C0;
wire P3P2P1P0C0;
wire P1G0;
wire P2P1G0;
wire P3P2P1G0;
wire P2G1;
wire P3P2G1;
wire P3G2;
assign P0C0=P[0]&C[0];
assign P1P0C0=P[1]&P0C0;
assign P2P1P0C0=P[2]&P1P0C0;
assign P3P2P1P0C0=P[3]&P2P1P0C0;
assign P1G0=P[1]&G[0];
assign P2P1G0=P[2]&P1G0;
assign P3P2P1G0=P[3]&P2P1G0;
assign P2G1=P[2]&G[1];
assign P3P2G1=P[3]&P2G1;
assign P3G2=P[3]&G[2];

assign C[1]=G[0] | P0C0;
assign C[2]=G[1] | P1G0 | P1P0C0;
assign C[3]=G[2] | P2G1 | P2P1G0 | P2P1P0C0;
assign C[4]=G[3] | P3G2 | P3P2G1 | P3P2P1G0 | P3P2P1P0C0;

// always@(*) begin
//     P0C0=P[0]&C[0];
//     P1P0C0=P[1]&P0C0;
//     P2P1P0C0=P[2]&P1P0C0;
//     P3P2P1P0C0=P[3]&P2P1P0C0;
//     P1G0=P[1]&G[0];
//     P2P1G0=P[2]&P1G0;
//     P3P2P1G0=P[3]&P2P1G0;
//     P2G1=P[2]&G[1];
//     P3P2G1=P[3]&P2G1;
//     P3G2=P[3]&G[2];

//     C[1]=G[0] | P0C0;
//     C[2]=G[1] | P1G0 | P1P0C0;
//     C[3]=G[2] | P2G1 | P2P1G0 | P2P1P0C0;
//     C[4]=G[3] | P3G2 | P3P2G1 | P3P2P1G0 | P3P2P1P0C0;
// end

endmodule

module adder16(
    input [15:0] A,
    input [15:0] B,
    input Ci,
    output [15:0] S,
    output Co,
    output Go,
    output Po
);
wire G3_0;
wire G7_4;
wire G11_8;
wire G15_12;
wire P3_0;
wire P7_4;
wire P11_8;
wire P15_12;

adder4 adder4_0(.A(A[3:0]),.B(B[3:0]),.Ci(Ci),.S(S[3:0]),.Co(),.Go(G3_0),.Po(P3_0));
adder4 adder4_1(.A(A[7:4]),.B(B[7:4]),.Ci(C4),.S(S[7:4]),.Co(),.Go(G7_4),.Po(P7_4));
adder4 adder4_2(.A(A[11:8]),.B(B[11:8]),.Ci(C8),.S(S[11:8]),.Co(),.Go(G11_8),.Po(P11_8));
adder4 adder4_3(.A(A[15:12]),.B(B[15:12]),.Ci(C12),.S(S[15:12]),.Co(),.Go(G15_12),.Po(P15_12));

assign Go=G15_12 | (P15_12&G11_8) | (P15_12&P11_8&G7_4) | (P15_12&P11_8&P7_4&G3_0);
assign Po=P15_12&P11_8&P7_4&P3_0;
assign Co=Go | (Po&Ci);

endmodule