module PC_reg (
    input clk, rst, freeze,
    input [31:0] PC_in,
    output reg [31:0] PC 
);

always @(posedge clk, posedge rst ) begin
    if (rst) begin
        PC = 32'd0;
    end else begin
        if (~freeze) begin
            PC = PC_in;
        end
    end
end


    
endmodule