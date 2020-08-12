module ARM (
    input clk, rst,forward
);

wire freeze, branch_taken,flush, hazard, wb_wb_en;
wire id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B, id_is_immediate; 
wire [3:0] id_exe_command, id_rotate_imm, id_dest, id_src2,id_src1;
wire [7:0] id_imm_8;
wire [23:0] id_signed_imm;
wire [31:0] branch_address;
wire [31:0] if_pc_out, if_instruction_out, if_reg_pc_out, if_reg_instruction_out;
wire [31:0] id_pc_out, id_reg_pc_out, id_val_rn, id_val_rm;
wire id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_B,id_reg_S, id_reg_immediate;
wire [3:0] id_reg_EXE_CMD,id_reg_rotate_imm,id_reg_Dest,id_reg_src1,id_reg_src2;
wire [7:0] id_reg_immed_8;
wire [23:0] id_reg_Signed_imm_24;
wire [31:0] id_reg_Val_Rn,id_reg_Val_Rm,id_reg_status_reg;
wire exe_wb_en, exe_mem_read, exe_mem_write; 
wire [3:0] exe_dest, exe_status_bits;
wire [31:0] exe_branch_address, exe_alu_res, exe_val_rm_out;
wire exe_reg_wb_out, exe_reg_mem_read, exe_reg_mem_write;
wire [3:0] exe_reg_dest_out;
wire [31:0] exe_reg_alu_res, exe_reg_val_rm;
wire mem_reg_wb_en, mem_reg_mem_read;
wire [3:0] mem_reg_dest_out;
wire [31:0] mem_reg_alu_out, data_mem_out, mem_reg_data_mem_out;
wire [31:0] wb_result;
wire [3:0] wb_dest;
wire [31:0] status_reg_out;
wire [1:0]sel_src1,sel_src2;
wire [31:0]mux1_val,mux2_val;

assign freeze = hazard;


assign flush= id_reg_B;

IF_stage IF(clk, rst, freeze, id_reg_B, exe_branch_address, if_pc_out, if_instruction_out);

IF_stage_reg IF_reg(clk, rst, freeze,flush ,if_pc_out, if_instruction_out, if_reg_pc_out,
 if_reg_instruction_out);

ID_stage ID(clk, rst, hazard, wb_wb_en, status_reg_out, wb_dest, if_reg_pc_out, if_reg_instruction_out,
 wb_result, id_pc_out, id_two_src, id_wb_en, id_mem_read_en, id_mem_write_en, id_S, id_B, 
 id_is_immediate, id_exe_command, 
 id_val_rn, id_val_rm, id_imm_8, id_rotate_imm, id_signed_imm, id_dest,id_src1, id_src2);


Hazard_detection hd(
    exe_wb_en, exe_reg_wb_out, id_two_src,
    if_reg_instruction_out[19:16], id_src2, exe_dest, exe_reg_dest_out,
    id_reg_MEM_R_EN,forward,
    hazard
);

Forwarding_unit FU(
    wb_wb_en, exe_reg_wb_out,forward,
    id_reg_src1,id_reg_src2, wb_dest, exe_reg_dest_out ,
    sel_src1, sel_src2
);



ID_stage_reg ID_reg(clk, rst,flush, id_pc_out,id_wb_en,id_mem_read_en ,id_mem_write_en,id_is_immediate ,
    id_exe_command,id_B,id_S,id_val_rn,id_val_rm,id_imm_8,id_rotate_imm,id_signed_imm
,id_dest,status_reg_out,id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_immediate 
,id_reg_EXE_CMD,id_reg_B,id_reg_S,id_reg_pc_out,id_reg_Val_Rn,id_reg_Val_Rm,id_reg_immed_8,
id_reg_rotate_imm,id_reg_Signed_imm_24,id_reg_Dest ,id_reg_status_reg,id_src1,id_src2,id_reg_src1,id_reg_src2);

assign mux1_val=(sel_src1==2'b00)?id_reg_Val_Rn:(sel_src1==2'b01)?exe_reg_alu_res:(sel_src1==2'b10)?wb_result:32'dx;
assign mux2_val=(sel_src2==2'b00)?id_reg_Val_Rm:(sel_src2==2'b01)?exe_reg_alu_res:(sel_src2==2'b10)?wb_result:32'dx;


EXE_stage EXE(clk, rst,id_reg_WB_EN,id_reg_MEM_R_EN,id_reg_MEM_W_EN,id_reg_immediate,
   id_reg_EXE_CMD, id_reg_rotate_imm, id_reg_Dest, id_reg_immed_8, id_reg_Signed_imm_24,
    id_reg_pc_out,mux1_val, mux2_val, id_reg_status_reg,
    exe_wb_en, exe_mem_read, exe_mem_write, exe_dest, exe_status_bits, exe_branch_address, exe_alu_res, exe_val_rm_out );

Status_register s_reg(clk, rst, id_reg_S, exe_status_bits, status_reg_out);

EXE_stage_reg EXE_reg(clk, rst, exe_wb_en, exe_mem_read, exe_mem_write, 
    exe_dest, exe_alu_res, exe_val_rm_out, exe_reg_wb_out, exe_reg_mem_read, 
    exe_reg_mem_write, exe_reg_dest_out, exe_reg_alu_res, exe_reg_val_rm);
MEM_stage MEM(clk, exe_reg_mem_read, exe_reg_mem_write, exe_reg_alu_res, exe_reg_val_rm, data_mem_out);

MEM_stage_reg MEM_reg(clk, rst, exe_reg_mem_read, exe_reg_wb_out,exe_reg_dest_out,
    exe_reg_alu_res,data_mem_out, mem_reg_wb_en, mem_reg_mem_read, mem_reg_dest_out, 
    mem_reg_alu_out, mem_reg_data_mem_out);

WB_stage WB(mem_reg_wb_en, mem_reg_mem_read, mem_reg_dest_out, mem_reg_alu_out, 
    mem_reg_data_mem_out, wb_wb_en, wb_dest, wb_result);
    
endmodule