`timescale 1ns / 1ps


module RegFile(
    clk, reset, rg_wrt_en,
    rg_wrt_addr,
    rg_rd_addr1,
    rg_rd_addr2,
    rg_wrt_data,
    rg_rd_data1,
    rg_rd_data2
    );
    
    // define input and output signals
    input clk, reset, rg_wrt_en;
    input [4:0] rg_wrt_addr, rg_rd_addr1, rg_rd_addr2;
    input [31:0] rg_wrt_data;
    output reg [31:0] rg_rd_data1, rg_rd_data2;
    
    reg [31:0] register_file [31:0];
    integer i;
    
    // define the Register File module's behavior
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for(i = 0; i < 32; i = i + 1) begin
                register_file[i] = 32'h00000000;
            end
        end else begin
            if (rg_wrt_en && rg_wrt_addr != 5'b0) begin // prevent writing to x0
                register_file[rg_wrt_addr] <= rg_wrt_data;
            end
        end
    end
    
    always @(rg_rd_addr1, rg_rd_addr2) begin
        rg_rd_data1 = register_file[rg_rd_addr1];
        rg_rd_data2 = register_file[rg_rd_addr2];
    end

endmodule // RegFile
