`timescale 1ps/1ps

module testbench();
logic  [15:0] A;
logic  [15:0] B;
logic  Ci;
logic [15:0] S;
logic Co;
int correct;
int wrong;

initial begin
    A=0;
    B=0;
    Ci=0;
    correct=0;
    wrong=0;
    #10
    $display("random test begin!");
    for(int i=0;i<4294967;i++) begin
        A={$random}%65536;
        B={$random}%65536;
        Ci={$random}%2;
        #1
        if({Co,S}==A+B+Ci) begin
            correct+=1;
            $display("%d + %d + %d = (%d) %d, right.",Ci,A,B,Co,S);
        end
        else begin
            wrong+=1;
            $display("%d + %d + %d = (%d) %d, wrong. should be %d.",Ci,A,B,Co,S,A+B);
        end
    end
    $display("random test done! %d correct(s), %d wrong(s)",correct,wrong);


end

KS_Adder KS(.A(A),.B(B),.Ci(Ci),.S(S),.Co(Co));

endmodule