`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/06 13:51:51
// Design Name: 
// Module Name: spiw
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

//interface wishbone_slave(
//    input  CLK_I,
//    input  RST_I,
    
//    input  ADR_I,
//    input  [7:0] DAT_I,
//    input  WE_I,
//    input  SEL_I,
//    input  STB_I,
//    input  CYC_I,
////    input TAGN_I,
////    output TAGN_O,
//    output DAT_O,
//    output ACK_O
//    );
    
//endinterface

//interface wishbone(input bit CLK,input bit RST);
//logic ADR,WE,SEL,STB,CYC,ACK;
//logic [7:0] DAT_0,DAT_1;
//modport master(input)
//endinterface

//interface spi_master(
//    output SCK_O,
//    input  MISO_I,
//    output MOSI_O,
//    output SS_O
//    );

//endinterface

module spiw(
    input  CLK_I,
    input  RST_I,
    
    input  WISHBONE_SLAVE_ADR_I,
    input  [7:0] WISHBONE_SLAVE_DAT_I,
    output [7:0] WISHBONE_SLAVE_DAT_O,
    input  WISHBONE_SLAVE_WE_I,
    input  WISHBONE_SLAVE_STB_I,
    output WISHBONE_SLAVE_ACK_O,
    input  WISHBONE_SLAVE_CYC_I,
    
    output SPI_MASTER_SCK_O,
    input  SPI_MASTER_MISO_I,
    output SPI_MASTER_MOSI_O
    );
    
    reg [7:0] cache[2];
    reg cache1_flag;//means that cache1's content waits to be transformed.
    //cache0 for divident ceiling. freq(SCK)==freq(sysclk)/divident/2 (?)
    //cache1 for data. 
    reg [7:0] spi_psr;//shift reg
    reg state;//0 for idle, 1 for raising ACK
    reg [3:0] counter;//counter for spi
    reg [7:0] divi_counter;
    reg [7:0] WISHBONE_SLAVE_DAT_O;
    reg WISHBONE_SLAVE_ACK_O;
    reg SPI_MASTER_MOSI_O;
    assign SPI_MASTER_SCK_O=(divi_counter==0);
        
always@(posedge CLK_I or posedge RST_I) begin
    if(RST_I)begin
        cache[0]<=8'b1;
        cache[1]<=8'b0;
        cache1_flag<=0;
        WISHBONE_SLAVE_ACK_O<=0;
        WISHBONE_SLAVE_DAT_O<=0;
        state<=0;
    end
    else begin
        if(WISHBONE_SLAVE_CYC_I && WISHBONE_SLAVE_STB_I && WISHBONE_SLAVE_WE_I)begin
            case(state) 
                0:begin//idle
                    state<=1;
                    if(WISHBONE_SLAVE_ADR_I==0) begin
                        if(WISHBONE_SLAVE_DAT_I==0) cache[0]<=1;
                        else cache[0]<=WISHBONE_SLAVE_DAT_I;
                        divi_counter<=0;
                    end
                    else begin
                        cache[1]<=WISHBONE_SLAVE_DAT_I;
                        cache1_flag<=1;
                    end
                end
                1:begin//raise ACK
                    WISHBONE_SLAVE_ACK_O<=1;
                end
            endcase
        end
        else begin
            WISHBONE_SLAVE_ACK_O<=0;
            state<=0;
            WISHBONE_SLAVE_DAT_O<=0;
        end
    end
end
    
always@(posedge CLK_I or posedge RST_I) begin
    if(RST_I) begin
        divi_counter<=0;
    end
    else begin
        if(divi_counter==cache[0]) divi_counter<=0;
        else divi_counter<=divi_counter+1;
    end
end

always@(SPI_MASTER_SCK_O or posedge RST_I) begin
    if(RST_I) begin
        spi_psr<=8'b0;
        counter<=0;
        SPI_MASTER_MOSI_O<=0;
    end
    else begin
        if(SPI_MASTER_SCK_O)begin
            if(counter==0)begin
                SPI_MASTER_MOSI_O<=0;
                if(cache1_flag==1) begin
                    counter<=1;
                    spi_psr<=cache[1];
                    if(~(WISHBONE_SLAVE_CYC_I && WISHBONE_SLAVE_STB_I && WISHBONE_SLAVE_WE_I && WISHBONE_SLAVE_ADR_I && (state==0))) cache1_flag<=0;
                end
            end
            else begin
                SPI_MASTER_MOSI_O<=spi_psr[7];
                spi_psr<=(spi_psr<<1);
                if(counter==8) counter<=0;
                else counter<=counter+1;
            end
        end
        else begin
            if(counter!=0 && counter!=1) spi_psr[0]<=SPI_MASTER_MISO_I;
        end
    end
end

endmodule
