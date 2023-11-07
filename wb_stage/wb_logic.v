module wb_logic(
    input wire clk,                     // Clock signal
    input wire reset,                   // Synchronous reset
    input wire mem_to_reg,              // Control signal to select memory read value or ALU result
    input wire [31:0] alu_result,       // Result from the ALU
    input wire [31:0] mem_read_data,    // Data read from data memory
    input wire [4:0] write_reg_addr,    // Register to write to
    input wire reg_write_en,            // Register write enable signal
    output reg [4:0] reg_write_addr,    // Address to write in the register file
    output reg [31:0] reg_write_data,   // Data to write into the register file
    output reg reg_write_enable         // Enable signal for register file write
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset write-back logic if reset signal is asserted
            reg_write_addr <= 5'b0;
            reg_write_data <= 32'b0;
            reg_write_enable <= 1'b0;
        end else begin
            // Update write-back data and address based on control signals
            reg_write_addr <= write_reg_addr;
            reg_write_enable <= reg_write_en;
            reg_write_data <= mem_to_reg ? mem_read_data : alu_result;
        end
    end

endmodule
