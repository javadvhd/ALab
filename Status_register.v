module Status_register (
    input clk, rst, S, 
    input [3:0] status_bits,
    output reg [31:0] status_reg_out
);

always @(negedge clk, posedge rst) begin
    if (rst) begin
        status_reg_out = 32'b0;
    end else if(S) begin
        status_reg_out[31:28] = status_bits;
    end
end
    
endmodule