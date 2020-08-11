module Hazard_detection (
    input exe_wb_en, mem_wb_en, two_src,
    input [3:0] src1, src2, exe_dest, mem_dest,
    output reg hazard_output
);

always @(*) begin
    if(exe_wb_en && (src1 == exe_dest))
        hazard_output=1'b1;
    else if(mem_wb_en && (src1 == mem_dest))
        hazard_output=1'b1;
    else if(two_src && exe_wb_en && (src2 == exe_dest))
        hazard_output=1'b1;
    else if(two_src && mem_wb_en && (src2 == mem_dest))
        hazard_output=1'b1;
    else
        hazard_output=1'b0;
end
endmodule