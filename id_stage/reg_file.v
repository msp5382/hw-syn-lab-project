module reg_file(
    input wire clk,                      // Clock signal
    input wire reset,                    // Synchronous reset
    input wire reg_write_en,             // Register write enable
    input wire [4:0] read_reg1,          // Address for read register 1
    input wire [4:0] read_reg2,          // Address for read register 2
    input wire [4:0] write_reg,          // Address for write register
    input wire [31:0] write_data,        // Data to write
    output wire [31:0] read_data1,       // Output data from read register 1
    output wire [31:0] read_data2        // Output data from read register 2
);

    // 32 registers of 32 bits each
    reg [31:0] registers [31:1];         // Register 0 is hardwired to 0

    // Read data (combinational logic)
    assign read_data1 = (read_reg1 == 0) ? 32'b0 : registers[read_reg1];
    assign read_data2 = (read_reg2 == 0) ? 32'b0 : registers[read_reg2];

    // Write data (synchronous logic)
    always @(posedge clk) begin
        if (reset) begin
            // Asynchronous reset to clear all registers
            integer i;
            for (i = 1; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (reg_write_en && (write_reg != 0)) begin
            // Write data to the register, but never to register 0
            registers[write_reg] <= write_data;
        end
    end

endmodule
