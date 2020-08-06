module EXE_stage_reg (
    input clk, rst,
    input [31:0] PC_in,
    output reg [31:0] PC 
);

always @(posedge clk) begin
    PC <= PC_in;
end


endmodule