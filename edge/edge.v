module edge(clk,rstn,in,out);
















































input clk,rstn,in;
output reg out;
//input都是wire,output默认是wire,也可重定义成reg

always@(posedge clk or negedge rstn) begin
    if(~rstn) begin
    //最好所有的reg都在此reset
        out<=0;    
    end
    else begin
        
    end
end

endmodule