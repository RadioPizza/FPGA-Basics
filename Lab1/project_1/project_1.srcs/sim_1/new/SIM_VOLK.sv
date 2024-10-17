`timescale 1ns / 1ps

module SIM_VOLK();
    logic [3:0] ABCD_reg;
    logic X;
    initial begin
        ABCD_reg <= 4'd0;
    end
    always begin
        #50 ABCD_reg += 4'b1;
    end
    VOLK test(.A(ABCD_reg[3]), .B(ABCD_reg[2]), .C(ABCD_reg[1]), .D(ABCD_reg[0]), .X(X));
endmodule
