module CU (
    input [1:0]mode,
    input [3:0]op_code,
    input S,
    output reg [3:0] exe_command,
    output reg mem_read, mem_write,
    output reg wb_enable,
    output reg is_immediate,
    output reg B,
    output update_status
);
assign update_status = S;
always @(*) begin
case (mode)
    2'd0: begin
        wb_enable = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        B=1'b0;
        case (op_code)
            4'b1101: exe_command = 4'b0001; //MOV
            4'b1111: exe_command = 4'b1001; //MVN
            4'b0100: exe_command = 4'b0010; //ADD
            4'b1001: exe_command = 4'b0011; //ADC
            4'b0010: exe_command = 4'b0100; //SUB
            4'b0110: exe_command = 4'b0101; //SBC
            4'b0000: exe_command = 4'b0110; //AND
            4'b1100: exe_command = 4'b0111; //ORR
            4'b0001: exe_command = 4'b1000; //EOR
            4'b1010: exe_command = 4'b0100; //CMP
            4'b1000: exe_command = 4'b0110; //TST
            default:exe_command = 4'b0000; //NOP
        endcase
    end
    2'd1: begin
        B=1'b0;
        exe_command = 4'b0010;
        wb_enable = 1'b0;
        case (S)
            1'b0 : begin
                mem_read = 1'b1;
                mem_write = 1'b0;
            end 
            1'b1 : begin
                mem_read =  1'b0;
                mem_write =  1'b1;
            end  
        endcase
    end
    2'b10: begin
        B = 1'b1; 
        mem_read = 1'b0;
        mem_write = 1'b0;
        exe_command = 4'b0;
        wb_enable = 1'b0;
    end 
    default: begin
        exe_command = 4'b0;
        wb_enable = 1'b0;
        B = 1'b0;
    end
endcase
end
    
endmodule