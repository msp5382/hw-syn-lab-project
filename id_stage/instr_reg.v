module instr_reg (
    input wire clk,               // Clock signal
    input wire reset,             // Synchronous reset signal
    input wire en,                // Enable signal to load the instruction
    input wire [31:0] instr_in,   // Input instruction from instruction memory
    output reg [31:0] instr_out   // Output instruction to the decode logic
);

    // Load the instruction on the rising edge of the clock if enabled
    // Reset asynchronously sets the instruction to zero
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Clear the instruction register if reset is asserted
            instr_out <= 32'b0;
        end
        else if (en) begin
            // Load the instruction into the register when enabled
            instr_out <= instr_in;
        end
    end

endmodule
