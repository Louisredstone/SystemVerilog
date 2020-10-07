`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/05 17:28:36
// Design Name: 
// Module Name: xytb
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


module xytb(
    );
reg clk;
reg rstn;
wire [7:0]data_x;

initial
begin
#10
rstn<=0;
clk<=0;
#20
rstn<=1;
end

always begin
#10
clk=~clk;
end
Helloxy xy(.clk(clk),.rstn(rstn),.data(data_x));
endmodule
