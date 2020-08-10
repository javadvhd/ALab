module Data_memory (
    input clk, mem_read, mem_write,
    input [31:0] val_rm, alu_res,
    output [31:0] value 
);
reg [31:0] memory [0:63];


assign value = mem_read ? memory[(((alu_res - 32'd1024) >> 2))]: 32'bx;

always @(posedge clk) begin
    if (mem_write) begin
        memory[(alu_res - 32'd1024)>>2] = val_rm; 
    end
end
    
endmodule