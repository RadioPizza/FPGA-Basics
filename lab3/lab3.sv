module lab3(
    input logic CLK100MHZ,
    input logic BTNC,
    input logic [5:3] SW,
    output logic [7:0] HEX,
    output logic [3:0] AN
);

// Clock and reset
logic [25:0] counter = 0;
logic [19:0] refresh_counter;
logic [1:0] anode_selector;
logic [3:0] current_digit;
logic dot;

// Display modes
typedef enum {
    MODE_OFF,
    MODE_VARIANT,
    MODE_GROUP,
    MODE_DATE
} display_mode;

display_mode mode;

// Switch priority logic
always_comb begin
    if (SW[5]) mode = MODE_VARIANT;
    else if (SW[4]) mode = MODE_GROUP;
    else if (SW[3]) mode = MODE_DATE;
    else mode = MODE_OFF;
end

// Dynamic display refresh (1 KHz)
always_ff @(posedge CLK100MHZ) begin
    refresh_counter <= refresh_counter + 1;
    if (refresh_counter == 100000) begin
        refresh_counter <= 0;
        anode_selector <= anode_selector + 1;
    end
end

// DATE mode: Scrolling text
localparam DATE_LEN = 10;
logic [3:0] date_digits [DATE_LEN-1:0] = '{
    4'hF, 4'h0, 4'h6, 4'h0, 4'h5, 4'h2, 4'h0, 4'h0, 4'h4, 4'hF
};
logic [DATE_LEN-1:0] date_dots = '{
    0, 0, 1, 0, 1, 0, 0, 0, 0, 0
};
logic [3:0] shift_pos = 0;

// Scrolling logic (0.5 sec delay)
always_ff @(posedge CLK100MHZ) begin
    if (mode == MODE_DATE) begin
        counter <= counter + 1;
        if (counter == 50000000) begin
            counter <= 0;
            shift_pos <= (shift_pos + 1) % DATE_LEN; // Smooth transition
        end
    end else begin
        counter <= 0;
        shift_pos <= 0;
    end
end

// Data control for 7-segment display
always_comb begin
    case(mode)
        MODE_VARIANT: begin // Display '11' on AN1 and AN0
            case(anode_selector)
                2'b00: begin // AN0
                    current_digit = 4'h1;
                    dot = 0;
                    AN = 4'b1110;
                end
                2'b01: begin // AN1
                    current_digit = 4'h1;
                    dot = 0;
                    AN = 4'b1101;
                end
                default: begin
                    current_digit = 4'hF;
                    dot = 0;
                    AN = 4'b1111;
                end
            endcase
        end
        
        MODE_GROUP: begin // Display '1A22' on AN3-AN0
            case(anode_selector)
                2'b00: begin // AN0
                    current_digit = 4'h2;
                    dot = 0;
                    AN = 4'b1110;
                end
                2'b01: begin // AN1
                    current_digit = 4'h2;
                    dot = 0;
                    AN = 4'b1101;
                end
                2'b10: begin // AN2
                    current_digit = 4'hA;
                    dot = 0;
                    AN = 4'b1011;
                end
                2'b11: begin // AN3
                    current_digit = 4'h1;
                    dot = 0;
                    AN = 4'b0111;
                end
            endcase
        end
        
        MODE_DATE: begin // Scrolling text
            logic [3:0] current_index;
            current_index = (shift_pos + anode_selector) % DATE_LEN; // Correct order
            current_digit = date_digits[current_index];
            dot = date_dots[current_index];
            AN = ~(4'b0001 << anode_selector);
        end
        
        default: begin // Display off
            current_digit = 4'hF;
            dot = 0;
            AN = 4'b1111;
        end
    endcase
end

// 7-segment decoder with dot control
seg7_decoder decoder(
    .data(current_digit),
    .dot(dot),
    .seg(HEX)
);

endmodule

module seg7_decoder(
    input logic [3:0] data,
    input logic dot,
    output logic [7:0] seg
);
always_comb begin
    case(data)
        4'h0: seg = {~dot, 7'b1000000}; // 0
        4'h1: seg = {~dot, 7'b1111001}; // 1
        4'h2: seg = {~dot, 7'b0100100}; // 2
        4'h3: seg = {~dot, 7'b0110000}; // 3
        4'h4: seg = {~dot, 7'b0011001}; // 4
        4'h5: seg = {~dot, 7'b0010010}; // 5
        4'h6: seg = {~dot, 7'b0000010}; // 6
        4'h7: seg = {~dot, 7'b1111000}; // 7
        4'h8: seg = {~dot, 7'b0000000}; // 8
        4'h9: seg = {~dot, 7'b0010000}; // 9
        4'hA: seg = {~dot, 7'b0001000}; // A
        4'hB: seg = {~dot, 7'b0000011}; // B
        4'hC: seg = {~dot, 7'b1000110}; // C
        4'hD: seg = {~dot, 7'b0100001}; // D
        4'hE: seg = {~dot, 7'b0000110}; // E
        4'hF: seg = {~dot, 7'b1111111}; // OFF
        default: seg = {~dot, 7'b1111111};
    endcase
end
endmodule