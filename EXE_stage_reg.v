module EXE_stage_reg (
    input clk, rst, wb_in, mem_read_in, mem_write_in, 
    input [3:0] dest,
    input [31:0] alu_res, val_rm, 
    output reg wb_out, mem_read_out, mem_write_out, 
    output reg [3:0] dest_out,
    output reg [31:0] alu_res_out, val_rm_out,
);

always @(posedge clk, posedge rst) begin
    if (rst) begin
        wb_out = 1'b0;
        mem_read_out = 1'b0;
        mem_write_out = 1'b0;
        dest_out = 4'bx;
        alu_res_out = 32'bx; 
        val_rm_out = 32'bx; 
    end else begin
        wb_out = wb_in;
        mem_read_out = mem_read_in;
        mem_write_out = mem_write_in;
        dest_out = dest;
        alu_res_out = alu_res; 
        val_rm_out = val_rm;
    end
end

endmodule