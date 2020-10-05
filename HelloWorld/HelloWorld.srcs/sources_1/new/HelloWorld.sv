`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/05 16:22:11
// Design Name: 
// Module Name: HelloWorld
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


module HelloWorld(
    input RSTN,
    input CLK,
    output [7:0] DATA
    );
    
reg [7:0] DATA_r;
reg [3:0] counter;

always@(posedge CLK or negedge RSTN)
begin
    if (RSTN == 0) begin
    DATA_r<=8'b0;
    counter<=4'b0;
    end
    else begin
        counter<=counter+1;
        case(counter)
            0: DATA_r<="H";
            1: DATA_r<="e";
            2: DATA_r<="l";
            3: DATA_r<="l";
            4: DATA_r<="o";
            5: DATA_r<="W";
            6: DATA_r<="o";
            7: DATA_r<="r";
            8: DATA_r<="l";
            9: DATA_r<="d";
            default: DATA_r<=0;
        endcase
    end
end

assign DATA[7:0]=DATA_r[7:0];
    
endmodule
