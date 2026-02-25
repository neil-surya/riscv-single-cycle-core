`timescale 1 ns / 1 ps

// module definition
module DataMem(MemRead, MemWrite, addr, write_data, read_data);
    // define I/O ports
    input MemRead, MemWrite;
    input [8:0] addr;
    input [31:0] write_data;
    output reg [31:0] read_data;
    
    reg [31:0] data_mem [127:0];  // memory array definition
    wire [6:0] mem_addr = addr[8:2];  // bits 2 to 8 for addressing
    
    // describe data_mem behavior
    assign read_data = (MemRead) ? data_mem[mem_addr] : 32'b0;

    always @(posedge clk) begin
        //if (MemRead) begin
        //    read_data = data_mem[mem_addr];  // read operation
        //end

        if (MemWrite) begin
            data_mem[mem_addr] <= write_data;  // write operation
        end
    end

endmodule  // data_mem
