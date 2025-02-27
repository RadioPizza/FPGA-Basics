`timescale 1ns / 1ps

module logic_unit(
    input  logic A,  // Input A
    input  logic B,  // Input B
    input  logic C,  // Input C
    input  logic D,  // Input D
    output logic X   // Output X
);

    // Combinational logic for the output
    always_comb begin
        X = (A ^ B) & (C | D);  // Logical operation: (A XOR B) AND (C OR D)
    end

endmodule