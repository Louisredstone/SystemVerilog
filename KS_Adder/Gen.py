import os

selfpath=os.path.split(os.path.realpath(__file__))[0]
filepath=os.path.join(selfpath,"KS_Adder.sv")
tbfilepath=os.path.join(selfpath,"KS_Adder_tb.sv")

N=16

"-----------------------------------------------------"

KS_dict={}
for i in range(N):
    j=i
    pow=1
    while(True):
        if(j==0):
            break
        else:
            tmp=min(pow,j)
            KS_dict[(i,j-tmp)]=((i,j),(j-1,j-tmp))
            j-=tmp
            pow*=2

result="""module KS_Adder(A,B,Ci,Co,S);
input  [{0}:0]A;
input  [{0}:0]B;
input  Ci;
output Co;
output [{0}:0]S;

wire   [{1}:0]C;
assign C[0]=Ci;
assign Co=C[{1}];

""".format(N-1,N)

for i in range(N):
    result+="wire P_{0}_{0},G_{0}_{0};\n".format(i)
for key in KS_dict:
    result+="wire P_{0}_{1},G_{0}_{1};\n".format(key[0],key[1])
result+="\n"

for i in range(N):
    result+="assign P_{0}_{0} = A[{0}] ^ B[{0}];\n".format(i)
for i in range(N):
    result+="assign G_{0}_{0} = A[{0}] & B[{0}];\n".format(i)
result+="\n"

for key,value in KS_dict.items():
    result+="dot dot_{0}_{1}(.Pi1(P_{2}_{3}),.Gi1(G_{2}_{3}),.Pi0(P_{4}_{5}),.Gi0(G_{4}_{5}),.Po(P_{0}_{1}),.Go(G_{0}_{1}));\n".format(key[0],key[1],value[0][0],value[0][1],value[1][0],value[1][1])
result+="\n"

for i in range(N):
    result+="assign C[{1}] = G_{0}_0 | (P_{0}_0 & C[0]);\n".format(i,i+1)
result+="\n"

for i in range(N):
    result+="assign S[{0}] = P_{0}_{0} ^ C[{0}];\n".format(i)
result+="\n"

result+="""endmodule

module dot(Pi1,Gi1,Pi0,Gi0,Po,Go);
//P"i:j" = P"i:m" & P"m-1:j"
//G"i:j" = G"i:m" | P"i:m" & G"m-i:j"
//Pi0: P"m-1:j"
//Gi0: G"m-1:j"
//Pi1: P"i:m"
//Gi1: G"i:m"
//Po:  P"i:j"
//Go:  G"i:j"
input  Pi0,Gi0,Pi1,Gi1;
output Po,Go;

assign Po = Pi1 & Pi0;
assign Go = Gi1 | (Pi1 & Gi0);
endmodule
"""

with open(filepath,"w") as f:
    f.write(result)

print("Module Design Generate Successful!")

"-------------------------------------------------"

result="""`timescale 1ps/1ps

module testbench();
logic  [{0}:0] A;
logic  [{0}:0] B;
logic  Ci;
logic [{0}:0] S;
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
    for(int i=0;i<{3};i++) begin
        A={2}%{1};
        B={2}%{1};
        Ci={2}%2;""".format(N-1,2**N,"{$random}",min(2**(2*N),65536**2//1000))
result+=r"""
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

endmodule"""

with open(tbfilepath,"w") as f:
    f.write(result)

print("Testbench Generate Successful!")