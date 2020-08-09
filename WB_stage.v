module WB_stage (
    input wb_en, mem_read, 
    input [3:0] dest,  
    input [31:0] alu, data_memory
    output wb_en_out,
    output [3:0] dest_out,
    output [31:0] value,
);

assign wb_en_out = wb_en ;  
assign dest_out = dest ;  
assign value = mem_read ? data_memory : alu;
endmodule