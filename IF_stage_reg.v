module IF_stage_reg (
    input clk, rst, freeze, flush,
    input [31:0] PC_in, instruction_in,
    output reg [31:0] PC, instruction 
);

always @(posedge clk) begin
    PC <= PC_in;
    instruction <=instruction_in;
end
    
endmodule