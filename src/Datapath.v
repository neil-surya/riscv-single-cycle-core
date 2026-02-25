`timescale 1 ns / 1 ps

// module definition
module data_path #(
    parameter PC_W = 8,                // Program Counter
    parameter INS_W = 32,              // Instruction Width
    parameter RF_ADDRESS = 5,          // Register File Address
    parameter DATA_W = 32,             // Data WriteData
    parameter DM_ADDRESS = 9,          // Data Memory Address
    parameter ALU_CC_W = 4             // ALU Control Code Width
)(                                     // Datapath Figure name
    input                  clk,        // CLK
    input                  reset,      // Reset
    input                  reg_write,  // RegWrite
    input                  mem2reg,    // MemtoReg
    input                  alu_src,    // ALUSrc
    input                  mem_write,  // MemWrite
    input                  mem_read,   // MemRead
    input  [ALU_CC_W-1:0]  alu_cc,     // ALUCC
    output          [6:0]  opcode,     // opcode
    output          [6:0]  funct7,     // Funct7
    output          [2:0]  funct3,     // Funct3   
    output   [DATA_W-1:0]  alu_result  // Datapath_Result
);
    
    // wires for inter-module connections
    wire [7:0] PC;
    wire [31:0] instruct, Reg1, Reg2, SrcB, ExtImm, WriteBack_Data, ALU_Result, DataMem_Read;
    
    // caused many errors so commented out
    // wire [RF_ADDRESS -1:0] rd_rg_wrt_wire, rd_rg_addr_wire1, rd_rg_addr_wire2;
    // assign rd_rg_wrt_wire = instruct[11:7];
    // assign rd_rg_wrt_wire1 = instruct[19:15];
    // assign rd_rg_wrt_wire2 = instruct[24:20];
    
    // instantiate lower level modules
    ALU_32 ALU_instant(.A_in(Reg1), .B_in(SrcB), .ALU_ctrl(alu_cc), .ALU_out(ALU_Result), .carry_out(carry_out), .zero(zero), .overflow(overflow));
    FlipFlop FF_instant(.clk(clk), .reset(reset), .d(PC + 4), .q(PC));
    ImmGen IG_instant(.InstCode(instruct[31:0]), .ImmOut(ExtImm));
    mux21 MUX0_instant(.S(alu_src), .D1(Reg2), .D2(ExtImm), .Y(SrcB));
    mux21 MUX1_instant(.S(mem2reg), .D1(ALU_Result), .D2(DataMem_Read), .Y(WriteBack_Data));
    InstMem IM_instant(.addr(PC), .instruction(instruct));
    DataMem DM_instant(.MemRead(mem_read), .MemWrite(mem_write), .addr(ALU_Result[8:0]), .write_data(Reg2), .read_data(DataMem_Read));
    RegFile RF_instant(.clk(clk), .reset(reset), .rg_wrt_en(reg_write), .rg_wrt_addr(instruct[11:7]), .rg_rd_addr1(instruct[19:15]), .rg_rd_addr2(instruct[24:20]), .rg_wrt_data(WriteBack_Data), .rg_rd_data1(Reg1), .rg_rd_data2(Reg2));
    
    assign opcode = instruct[6:0];
    assign funct7 = instruct[31:25];
    assign funct3 = instruct[14:12];
    assign alu_result = ALU_Result;

endmodule  // Datapath
