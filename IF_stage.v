module IF_stage (
    input clk, rst, freeze, branch_taken,
    input [31:0] branch_address,
    output [31:0] inc_pc, instruction
);
wire [31:0] pc;
wire [31:0] pc_in;
assign pc_in = branch_taken ? branch_address : pc + 32'd4;
assign inc_pc=pc+32'd4;
IM im(clk, pc, instruction);
PC_reg PC(clk, rst, freeze, pc_in,pc);
    
endmodule