module led_flow(
    input clk,
    input rstn,

    output [9:0]led
);

parameter freq 25000000;

reg [9:0]led;
reg [31:0]counter;
wire sck;
assign sck=(counter == 0);

always@(negedge rstn) begin
    led<=10'b0;
    counter <= 0;
end

always@(posedge sck) begin
    if (led == 0) led[0]<=1'b1;
    led<=(led<<1);
    
end

always@(posedge clk) begin
    if(counter == freq) counter<=0;
    else counter<=counter+1;
end

endmodule