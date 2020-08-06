module ARM (
    input clk, rst
);

wire freeze, branch_taken,flush, hazard, wb_wb_en;
wire id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B; 
wire [3:0] id_exe_command, id_rotate_imm, id_dest;
wire [7:0] id_imm_8;
wire [23:0] id_signed_imm;
wire [31:0] branch_address;
wire [31:0] if_pc_out, if_instruction_out, if_reg_pc_out, if_reg_instruction_out;
wire [31:0] id_pc_out, id_reg_pc_out, id_val_rn, id_val_rm;
wire [31:0] exe_pc_out, exe_reg_pc_out;
wire [31:0] mem_pc_out, mem_reg_pc_out;
wire [31:0] wb_pc_out, wb_dest, wb_result;
wire [31:0] status_reg_out;

assign freeze = 1'd0;
assign hazard = 1'b0;
assign branch_taken = 1'd0;
assign branch_address = 32'd0;
assign flush=1'd0;
assign status_reg_out={4'b1111,28'b0};

IF_stage IF(clk, rst, freeze, branch_taken, branch_address, if_pc_out, if_instruction_out);
IF_stage_reg IF_reg(clk, rst, freeze,flush ,if_pc_out, if_instruction_out, if_reg_pc_out, if_reg_instruction_out);
ID_stage ID(clk, rst, hazard, wb_wb_en, status_reg_out, wb_dest, if_reg_pc_out, if_reg_instruction_out,
 wb_result, id_pc_out, id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B, id_exe_command, 
 id_val_rn, id_val_rm, id_imm_8, id_rotate_imm, id_signed_imm, id_dest);

ID_stage_reg ID_reg(clk, rst, id_pc_out, id_reg_pc_out);
EXE_stage EXE(clk, rst, id_reg_pc_out, exe_pc_out);
EXE_stage_reg EXE_reg(clk, rst, exe_pc_out, exe_reg_pc_out);
MEM_stage MEM(clk, rst, exe_reg_pc_out, mem_pc_out);
MEM_stage_reg MEM_reg(clk, rst, mem_pc_out, mem_reg_pc_out);
WB_stage WB(clk, rst, mem_reg_pc_out, wb_pc_out);
    
endmodule