module RegisterFile (
    input clk, rst,
    input[3:0] src1, src2, Dest_wb,
    input [31:0] Result_wb,
    input writeBackEn,
    output[31:0] reg1, reg2  
);

reg [31:0] regs [15:0];

initial begin
    regs[0] = 32'd0;
    regs[1] = 32'd1;
    regs[2] = 32'd2;
    regs[3] = 32'd3;
    regs[4] = 32'd4;
    regs[5] = 32'd5;
    regs[6] = 32'd6;
    regs[7] = 32'd7;
    regs[8] = 32'd8;
    regs[9] = 32'd9;
    regs[10] = 32'd10;
    regs[11] = 32'd11;
    regs[12] = 32'd12;
    regs[13] = 32'd13;
    regs[14] = 32'd14;
end
    
assign reg1 = regs[src1];   
assign reg2 = regs[src2];   

always @(negedge clk) begin
    if (writeBackEn) begin
        regs[Dest_wb] = Result_wb;
    end
end


endmodule