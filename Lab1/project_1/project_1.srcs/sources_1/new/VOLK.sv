`timescale 1ns / 1ps

module VOLK(
    input A,
    input B,
    input C,
    input D,
    output logic X
);

    always_comb begin
        X = (A ^ B) & (C | D);
    end

endmodule
