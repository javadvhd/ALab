module EXE_stage (
    input clk, rst, wb_en_in, mem_read_in, mem_write_in, I,
    input [3:0] exe_command_in, imm_rotate, dest,
    input [7:0] imm_8,
    input [23:0] signed_immediate_24,
    input [31:0] PC_in, val_rn,val_rm, status_reg_out,
    output wb_en_out, mem_read_out, mem_write_out,
    output [3:0] dest_out, status_bits_out,
    output [31:0] branch_address, alu_res, val_rm_out
);

wire [31:0] val2_generator_out;
ALU alu(exe_command_in, val_rn, val2_generator_out, status_reg_out, status_bits_out, alu_res);
Val2Generator val2G(mem_write_in | mem_read_in, I, imm_rotate, imm_8, val_rm, val2_generator_out);    
assign branch_address = ({{8{signed_immediate_24[23]}},signed_immediate_24} << 2) + PC_in;
assign wb_en_out = wb_en_in;
assign mem_read_out = mem_read_in;
assign mem_write_out = mem_write_in;
assign val_rm_out = val_rm;
assign dest_out = dest;
endmodule