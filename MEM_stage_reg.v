module MEM_stage_reg (
    input clk, rst, mem_read, wb_en,
    input [3:0] dest, 
    input [31:0] alu, 
    // input [31:0] data_memory,
    output reg wb_en_out, mem_read_out, 
    output reg [3:0] dest_out,  
    output reg [31:0] alu_out
    // ,output reg [31:0] data_memory_out, 

);
    
always @(posedge clk, posedge rst) begin
    if (rst) begin
        wb_en_out = 1'b0;
        mem_read_out = 1'b0;
        dest_out = 4'bx;
        alu_out = 32'bx;
        // data_memory_out = 32'bx;
    end else begin
        wb_en_out = wb_en;
        mem_read_out = mem_read;
        dest_out = dest;
        alu_out = alu;
        // data_memory_out = data_memory;
    end
end
endmodule