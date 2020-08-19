module Forwarding_unit (
    input wb_wb, mem_wb,forward,
    input [3:0] src1, src2, wb_dest, mem_dest,
    output reg [1:0] sel_src1, sel_src2
);

always @(*) begin
    if(forward) begin
        if (mem_wb && (src1 == mem_dest)) begin
            sel_src1 = 2'b01;
        end else if(wb_wb && (src1 == wb_dest)) begin
            sel_src1 = 2'b10;
        end else  begin
            sel_src1 = 2'b00;
        end
        
        if (mem_wb && (src2 == mem_dest)) begin
            sel_src2 = 2'b01;
        end else if(wb_wb && (src2 == wb_dest)) begin
            sel_src2 = 2'b10;
        end else  begin
            sel_src2 = 2'b00;
        end
    end

    else begin
        sel_src1 = 2'b00;
        sel_src2 = 2'b00;
    end


end
endmodule