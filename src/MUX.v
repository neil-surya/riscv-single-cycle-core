`timescale 1ns / 1ps

// module definition
module mux21(
    input S,
    input [31:0] D1,
    input [31:0] D2,
    output [31:0] Y);
    
    // define MUX 2:1 module behavior
    assign Y = S ? D2 : D1;
    
endmodule
