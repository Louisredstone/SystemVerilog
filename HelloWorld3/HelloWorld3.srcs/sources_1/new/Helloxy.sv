`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/05 17:15:45
// Design Name: 
// Module Name: Helloxy
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


module Helloxy(
    input clk,
    input rstn,
    output [7:0] data
    );
wire clk;
wire rstn;
reg [7:0] data;
reg [4:0]counter;

always@(posedge clk or negedge rstn)
begin
if(rstn == 0)begin
data <= 0;
counter<=0;
end
else
begin
counter<=counter+1;
end
end

always@(*)
begin
case(counter)
0:data<="H";
1:data<="e";
2:data<="l";
3:data<="l";
4:data<="o";
5:data<="w";
6:data<="o";
7:data<="r";
8:data<="l";
9:data<="d";
default:data<=0;
endcase
end
endmodule
