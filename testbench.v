

module Arm_tb();
    reg clk=0,rst=0,forward=0;
    ARM m(clk,rst,forward);

    initial repeat (500) #10 clk=~clk;

    initial begin
        #2 rst=1;
        #2 rst=0;
        
    end
endmodule 