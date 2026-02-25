`timescale 1ns / 1ps

// module definition
module FlipFlop(clk, reset, d, q);

    // define input and output signals
    input clk, reset; // clock & reset signal
    input [7:0] d; // data input
    output reg [7:0] q;

    // define the D Flip Flop module's behavior
    always @(posedge clk)
        begin
            if (reset == 1'b1)
                q <= 8'b00000000;
            else
                q <= d;
        end

endmodule // FlipFlop
