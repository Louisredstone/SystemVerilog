module led_flow(
    input clk,
    input rstn,

    output [9:0]led_o
);

parameter freq = 25000000;

reg [9:0]led;
assign led_o=led;
reg [31:0]counter;
wire sck;
assign sck=(counter == 0);

always@(posedge sck or negedge rstn) begin
    if(!rstn) begin
        led<=10'b0;
	 end
	 else begin
        if (led == 0) led<=10'h01;
        led<=(led<<1);
    end
end

always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
        counter<=32'b0;
	 end
	 else begin
        if(counter == freq) counter<=32'b0;
        else counter<=counter+1;
	 end
end

endmodule