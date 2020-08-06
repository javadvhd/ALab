module IM (
    input clk,
    input [31:0] PC_in,
    output reg [31:0] instruction 
);

always @(posedge clk) begin
    case (PC_in)
        32'd0 : instruction <= {6'b0,5'd1,5'd2,5'd0,11'd0}; 
        32'd4 : instruction <= {6'b0,5'd3,5'd4,5'd0,11'd0};
        32'd8 : instruction <= {6'b0,5'd5,5'd6,5'd0,11'd0};
        32'd12 : instruction <= {6'b0,5'd7,5'd8,5'd2,11'd0};
        32'd16 : instruction <= {6'b0,5'd9,5'd10,5'd3,11'd0};
        32'd20 : instruction <= {6'b0,5'd11,5'd12,5'd0,11'd0};
        32'd24 : instruction <= {6'b0,5'd13,5'd14,5'd0,11'd0};
        default: instruction <= 32'd0;
    endcase
end


    
endmodule