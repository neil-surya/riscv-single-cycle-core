`timescale 1ns / 1ps

// module definition
module ALU_32(A_in, B_in, ALU_ctrl, ALU_out, carry_out, zero, overflow);
    // define I/O ports
    input [31:0] A_in, B_in;
    input [3:0] ALU_ctrl;
    output [31:0] ALU_out;
    output overflow, zero, carry_out;
    reg [31:0] ALU_reg;
    reg [32:0] tmp;
    
    // describe ALU behavior
    assign ALU_out = ALU_reg;
    assign carry_out = tmp[32];
    always @(*)

    begin
        case(ALU_ctrl)
            // AND function
            4'b0000: ALU_reg = A_in & B_in;
            // OR function
            4'b0001: ALU_reg = A_in | B_in;
            // addition function (signed)
            4'b0010: {tmp, ALU_reg} = $signed(A_in) + $signed(B_in);
            // subtraction function (signed)
            4'b0110: {tmp, ALU_reg} = $signed(A_in) - $signed(B_in);
            // set less than (slt) function (signed)
            4'b0111: ALU_reg = $signed(A_in) < $signed(B_in);
            // NOR function
            4'b1100: ALU_reg = ~(A_in | B_in);
            // equal comparison function
            4'b1111: ALU_reg = A_in == B_in;
            default: {tmp, ALU_reg} = $signed(A_in) + $signed(B_in); // default addition (signed)
        endcase
    end
    
    assign overflow = (A_in[31] == B_in[31]) & (A_in[31] != ALU_out[31]);
    assign zero = (ALU_out == 32'b0);
    
endmodule // 32-bit ALU
