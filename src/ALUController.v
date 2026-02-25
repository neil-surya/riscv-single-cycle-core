`timescale 1ns / 1ps

// module definition
module ALUController (
    ALUOp, Funct7, Funct3, Operation
    );

    // define the input and output signals
    input [1:0] ALUOp;
    input [6:0] Funct7;
    input [2:0] Funct3;
    output [3:0] Operation;

    // define the ALUController modules behavior

    // Operation 0 bit
    assign Operation[0]=
        ((Funct3[1] == 1)&&
         (Funct3 != 3'b111)&&
         (ALUOp[0] == 0))
         ? 1'b1 : 1'b0;

    // Operation 1 bit
    assign Operation[1] = (Funct3[2] == 1) ? 1'b0 : 1'b1;

    // Operation 2 bit
    assign Operation[2]=
        ((Funct3 == 3'b100)||
         (Funct7[5] == 1 && Funct3 == 3'b000)||
         (Funct3 == 3'b010 && ALUOp[0] != 1))
         ? 1'b1 : 1'b0;

    // Operation 3 bit
    assign Operation[3] = (Funct3 == 3'b100) ? 1'b1 : 1'b0;

endmodule // ALUController
