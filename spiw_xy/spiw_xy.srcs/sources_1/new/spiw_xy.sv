`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/08 15:28:00
// Design Name: 
// Module Name: spiw_xy
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


module spiw_xy(
input WISHBONE_SLAVE_CLK_I,
input WISHBONE_SLAVE_RST_I,
input WISHBONE_SLAVE_ADR_I,
input WISHBONE_SLAVE_DAT_I,
input WISHBONE_SLAVE_WE_I,
input WISHBONE_SLAVE_CYC_I,
input WISHBONE_SLAVE_STB_I,
output WISHBONE_SLAVE_ACK_O,

output SPI_MASTER_SCK_O,
output SPI_MASTER_MOSI_O
    );

reg WISHBONE_SLAVE_ACK_O;
reg [7:0]SSPBUF[2];
reg [7:0]Divident_Counter;
reg [7:0]Divident_Nmuber;
reg SPI_MASTER_MOSI_O;
reg [7:0]SPI_MASTER_SSPSR;
reg SPI_MASTER_SCK_O;
assign SPI_MASTER_SCK_O = (Divident_Counter==0);

always@( posedge WISHBONE_SLAVE_RST_I)
begin
WISHBONE_SLAVE_ACK_O<=0;
SSPBUF[0]<=0;
SSPBUF[1]<=0;
SPI_MASTER_MOSI_O<=0;
SPI_MASTER_SSPSR<=0;
SPI_MASTER_SCK_O<=0;
end

always@(posedge WISHBONE_SLAVE_CLK_I)
begin
if(WISHBONE_SLAVE_WE_I&&WISHBONE_SLAVE_CYC_I&& WISHBONE_SLAVE_STB_I&&WISHBONE_SLAVE_ACK_O)
begin
case(WISHBONE_SLAVE_ADR_I)
0:SSPBUF[0]<=WISHBONE_SLAVE_DAT_I;
1:SSPBUF[1]<=WISHBONE_SLAVE_DAT_I;
endcase
WISHBONE_SLAVE_ACK_O<=0;
end
else
begin

end
end

always@(posedge WISHBONE_SLAVE_CLK_I)
begin

end

 
endmodule
