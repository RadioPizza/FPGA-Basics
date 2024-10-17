`timescale 1ns / 1ps

module VOLK(
    input logic A,
    input logic B,
    input logic C,
    input logic D,
    output logic X
);

    always_comb begin
        X = (A ^ B) & (C | D);
    end

endmodule
