

module Arm_tb();
    reg clk=0,rst=0,forward=1;
    ARM m(clk,rst,forward);

    initial repeat (5000) #10 clk=~clk;

    initial begin
        #2 rst=1;
        #2 rst=0;
        
    end
endmodule 