module ARM (
    input clk, rst
);

wire freeze, branch_taken,flush, hazard, wb_wb_en;
wire id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B, id_is_immediate; 
wire [3:0] id_exe_command, id_rotate_imm, id_dest;
wire [7:0] id_imm_8;
wire [23:0] id_signed_imm;
wire [31:0] branch_address;
wire [31:0] if_pc_out, if_instruction_out, if_reg_pc_out, if_reg_instruction_out;
wire [31:0] id_pc_out, id_reg_pc_out, id_val_rn, id_val_rm;
wire id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_B,id_reg_S, id_reg_immediate;
wire [3:0] id_reg_EXE_CMD,id_reg_rotate_imm,id_reg_Dest;
wire [7:0] id_reg_immed_8;
wire [23:0] id_reg_Signed_imm_24;
wire [31:0] id_reg_Val_Rn,id_reg_Val_Rm,id_reg_status_reg;
wire exe_wb_en, exe_mem_read, exe_mem_write; 
wire [3:0] exe_dest, exe_status_bits;
wire [31:0] exe_pc_out, exe_reg_pc_out, exe_branch_address, exe_alu_res, exe_val_rm_out;
wire [31:0] mem_pc_out, mem_reg_pc_out;
wire [31:0] wb_pc_out, wb_result;
wire [3:0] wb_dest;
wire [31:0] status_reg_out;

assign freeze = 1'd0;
assign wb_wb_en=1'b0;
assign hazard = 1'b0;
assign branch_taken = 1'd0;
assign branch_address = 32'd0;
assign flush=1'd0;
assign status_reg_out={4'b0,28'b0};

IF_stage IF(clk, rst, freeze, branch_taken, branch_address, if_pc_out, if_instruction_out);
IF_stage_reg IF_reg(clk, rst, freeze,flush ,if_pc_out, if_instruction_out, if_reg_pc_out,
 if_reg_instruction_out);
ID_stage ID(clk, rst, hazard, wb_wb_en, status_reg_out, wb_dest, if_reg_pc_out, if_reg_instruction_out,
 wb_result, id_pc_out, id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B, 
 id_is_immediate, id_exe_command, 
 id_val_rn, id_val_rm, id_imm_8, id_rotate_imm, id_signed_imm, id_dest);

ID_stage_reg ID_reg(clk, rst,flush, id_pc_out,id_wb_en,id_mem_read_en ,id_mem_write_en,id_is_immediate ,
    id_exe_command,id_B,id_S,id_val_rn,id_val_rm,id_imm_8,id_rotate_imm,id_signed_imm
,id_dest,status_reg_out,id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_immediate 
,id_reg_EXE_CMD,id_reg_B,id_reg_S,id_reg_pc_out,id_reg_Val_Rn,id_reg_Val_Rm,id_reg_immed_8,
id_reg_rotate_imm,id_reg_Signed_imm_24,id_reg_Dest ,id_reg_status_reg);
EXE_stage EXE(clk, rst,id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_immediate,
   id_reg_EXE_CMD, id_reg_rotate_imm, id_reg_Dest, id_reg_immed_8, id_reg_Signed_imm_24,
    id_reg_pc_out, id_reg_Val_Rn, id_reg_Val_Rm, id_reg_status_reg,
    exe_wb_en, exe_mem_read, exe_mem_write, exe_dest, exe_status_bits, exe_branch_address, exe_alu_res, exe_val_rm_out );

EXE_stage_reg EXE_reg(clk, rst, exe_pc_out, exe_reg_pc_out);
MEM_stage MEM(clk, rst, exe_reg_pc_out, mem_pc_out);
MEM_stage_reg MEM_reg(clk, rst, mem_pc_out, mem_reg_pc_out);
WB_stage WB(clk, rst, mem_reg_pc_out, wb_pc_out);
    
endmodule