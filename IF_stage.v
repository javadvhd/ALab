module IF_stage (
    input clk, rst, freeze, branch_taken,
    input [31:0] branch_address,
    output [31:0] pc, instruction
);

wire [31:0] pc_in;
assign pc_in = pc + 32'd4;


IM im(clk, pc, instruction);
PC_reg PC(clk, rst, freeze, pc_in,pc);
    
endmodule