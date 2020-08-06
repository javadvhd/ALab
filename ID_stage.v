module ID_stage (
    input clk, rst,hazard, wb_wb_enable,
    input [31:0] status_reg_out, wb_dest,
    input [31:0] PC_in, insruction, wb_result,
    output [31:0] PC,
    output two_src, wb_en, mem_read_en, mem_write_en, S, B,
    output [3:0] exe_command,
    output [31:0] val_rn, val_rm,
    output [7:0] imm_8,
    output [3:0] rotate_imm,
    output [23:0] signed_imm,
    output [3:0] dest
);

wire [3:0] src2;
wire cu_S,cu_B, cu_mem_write_en, cu_mem_read_en, cu_wb_en, cu_is_immediate, c_check_out, control_sig_selector;
wire [3:0] cu_exe_command; 
assign src2 = (mem_write_en) ? insruction[15:12] : insruction[3:0];
assign control_sig_selector = hazard || (~c_check_out);
assign {exe_command, wb_en, mem_read_en, mem_write_en, S, B} = control_sig_selector ?  9'b0: {cu_exe_command, cu_wb_en, cu_mem_read_en,cu_mem_write_en, cu_S, cu_B};
assign two_src = (~insruction[25]) || mem_write_en;
assign imm_8 = insruction[7:0];
assign rotate_imm = insruction[11:8];
assign signed_imm = insruction[23:0];
assign dest = insruction[15:12];

RegisterFile RF(clk, rst, insruction[19:16], src2, wb_dest,wb_result,wb_wb_enable,val_rn, val_rm);

CU cu(insruction[27:26],insruction[24:21],insruction[20], cu_exe_command, cu_mem_read_en, cu_mem_write_en,
 cu_wb_en, cu_is_immediate, cu_B, cu_S);
Condition_check C_check(insruction[31:28],status_reg_out, c_check_out);
assign PC = PC_in;
    
endmodule