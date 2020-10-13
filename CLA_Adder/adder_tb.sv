`timescale 1ns/1ps

module adder_tb();

reg [3:0] A;
reg [3:0] B;
reg Ci;
wire [3:0] S;
wire Co;
wire Go;
wire Po;

adder4 adder4_0(.A(A),.B(B),.Ci(Ci),.S(S),.Co(Co),.Go(Go),.Po(Po));

// interger i;
// interger j;

initial begin
    Ci=0;
    A=5;
    B=7;
    #10
    $display("%d+%d=%d,  %d",A,B,S,Co);
    // for(i=0;i<16;i++) begin
    //     A=i;
    //     for(j=0;j<16;j++) begin
    //         B=j;
    //         #10
    //         $display("%d+%d=%d,  %d",A,B,S,Co);
    //     end
    // end
    // Ci=1;
    // for(i=0;i<16;i++) begin
    //     A=i;
    //     for(j=0;j<16;j++) begin
    //         B=j;
    //         #10
    //         $display("%d+%d+1=%d,  %d",A,B,S,Co);
    //     end
    // end
end

endmodule