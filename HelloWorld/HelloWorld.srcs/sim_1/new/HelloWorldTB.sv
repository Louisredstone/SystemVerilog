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
    
//wire CLK;
//wire RSTN;
//wire [7:0] DATA;

reg[8*14:1] stringvar; 
initial 
begin 
stringvar="Hello China"; 
$display("%s is stored as %h",stringvar,stringvar); 
stringvar={stringvar,"!!!"}; 
$display("%s is stored as %h",stringvar,stringvar); 
end 
endmodule
   
