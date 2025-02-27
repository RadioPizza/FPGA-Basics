`timescale 1ns / 1ps

module tb_logic_unit();
    logic [3:0] ABCD_reg;  // Input signals for A, B, C, D
    logic X;               // Output signal

    initial begin
        ABCD_reg <= 4'd0;  // Initialize inputs
    end

    always begin
        #50 ABCD_reg += 4'b1;  // Increment inputs every 50 time units
    end

    // Instantiate the logic unit module
    logic_unit dut (
        .A(ABCD_reg[3]),
        .B(ABCD_reg[2]),
        .C(ABCD_reg[1]),
        .D(ABCD_reg[0]),
        .X(X)
    );
endmodule