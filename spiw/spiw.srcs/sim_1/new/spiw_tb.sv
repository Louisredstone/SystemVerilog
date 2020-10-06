`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/06 15:11:08
// Design Name: 
// Module Name: spiw_tb
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


module spiw_tb(
    );
    
reg CLK,RST;

reg WISHBONE_ADR,WISHBONE_WE,WISHBONE_STB,WISHBONE_CYC;
wire WISHBONE_ACK;
reg [7:0] WISHBONE_DAT_0;
wire [7:0] WISHBONE_DAT_1;

wire SPI_SCK,SPI_MOSI;
reg SPI_MISO;

spiw spiw_0(
    .CLK_I(CLK),
    .RST_I(RST),
    
    .WISHBONE_SLAVE_ADR_I(WISHBONE_ADR),
    .WISHBONE_SLAVE_DAT_I(WISHBONE_DAT_0),
    .WISHBONE_SLAVE_DAT_O(WISHBONE_DAT_1),
    .WISHBONE_SLAVE_WE_I(WISHBONE_WE),
    .WISHBONE_SLAVE_STB_I(WISHBONE_STB),
    .WISHBONE_SLAVE_ACK_O(WISHBONE_ACK),
    .WISHBONE_SLAVE_CYC_I(WISHBONE_CYC),
    
    .SPI_MASTER_SCK_O(SPI_SCK),
    .SPI_MASTER_MISO_I(SPI_MISO),
    .SPI_MASTER_MOSI_O(SPI_MOSI)
);
    
initial begin
    #0
    CLK=0;
    RST=0;
    SPI_MISO=0;
    WISHBONE_DAT_0=0;
    WISHBONE_ADR=0;
    WISHBONE_WE=0;
    WISHBONE_STB=0;
    WISHBONE_CYC=0;
    #10
    RST=1;
    #10
    RST=0;

    #20
    WISHBONE_DAT_0=2;
    WISHBONE_ADR=0;
    WISHBONE_WE=1;
    WISHBONE_STB=1;
    WISHBONE_CYC=1;
    while(WISHBONE_ACK==0)begin
        #10
        $display("waiting for ACK.");
    end
    WISHBONE_WE=0;
    WISHBONE_CYC=0;
    WISHBONE_STB=0;

    #50
    WISHBONE_DAT_0=8'b01010101;
    WISHBONE_ADR=1;
    WISHBONE_WE=1;
    WISHBONE_STB=1;
    WISHBONE_CYC=1;
    while(WISHBONE_ACK==0)begin
        #10
        $display("waiting for ACK.");
    end
    WISHBONE_WE=0;
    WISHBONE_CYC=0;
    WISHBONE_STB=0;

    #50
    WISHBONE_DAT_0=8'b11100011;
    WISHBONE_ADR=1;
    WISHBONE_WE=1;
    WISHBONE_STB=1;
    WISHBONE_CYC=1;
    while(WISHBONE_ACK==0)begin
        #10
        $display("waiting for ACK.");
    end
    WISHBONE_WE=0;
    WISHBONE_CYC=0;
    WISHBONE_STB=0;
end

always begin
    #10
    CLK=~CLK;
end

endmodule
