module Condition_check (
    input [3:0] cond,
    input [31:0] status_reg_out,
    output reg cond_check_out
);
wire N,Z_,C,V;

assign N = status_reg_out[31];
assign Z_ = status_reg_out[30];
assign C = status_reg_out[29];
assign V = status_reg_out[28];
always @(*) begin
case(cond)
    4'b0000:    cond_check_out = Z_;
    4'b0001 :   cond_check_out = ~Z_;
    4'b0010 :   cond_check_out = C;
    4'b0011 :   cond_check_out = ~C;
    4'b0100 :   cond_check_out = N;
    4'b0101 :   cond_check_out = ~N;
    4'b0110 :   cond_check_out = V;
    4'b0111 :   cond_check_out = ~V;
    4'b1000 :   cond_check_out = C && (~Z_);
    4'b1001 :   cond_check_out = (~C) && Z_;
    4'b1010 :   cond_check_out = (N ~^ V);
    4'b1011 :   cond_check_out = N ^ V;
    4'b1100 :   cond_check_out = ~Z_ && (N ~^ V);
    4'b1101 :   cond_check_out = Z_ && (N ^ V);
    4'b1110 :   cond_check_out = 1'b1;
    default:    cond_check_out = 1'b1;
endcase
end

endmodule