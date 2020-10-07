`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/05 16:23:52
// Design Name: 
// Module Name: HelloWorldTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HelloWorldTB();
    
reg CLK;
reg RSTN;
wire [7:0] DATA;

initial 
begin 
$display("Testing...");
RSTN=1;
CLK=0;
end 

always
begin
    #10
    CLK=~CLK;
end

always
begin
    #20
    RSTN=0;
    #20
    RSTN=1;
    #230
    RSTN=1;
end

always
begin
    #20
    $display("%s",DATA);
end

HelloWorld2 hw(.RSTN(RSTN),.CLK(CLK),.DATA(DATA));

endmodule
   
