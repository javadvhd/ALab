module Hazard_detection (
    input exe_wb_en, mem_wb_en, two_src
    input [4:0] src1, src2, exe_dest, mem_dest,
    output hazard_output
);


assign hazard_output = (exe_wb_en && (src1 == exe_dest)) || (mem_wb_en && (src1 == mem_dest)) || 
    (two_src && exe_wb_en && (src2 == exe_dest)) || (two_src && mem_wb_en && (src2 == mem_dest))

endmodule