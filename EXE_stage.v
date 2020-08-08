module EXE_stage (
    input clk, rst,
    input [31:0] PC_in,
    output [31:0] PC 
);
ALU alu()
assign PC = PC_in;
    
endmodule