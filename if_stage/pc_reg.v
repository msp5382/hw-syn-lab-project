module pc_reg (
    input wire clk,             // Clock signal
    input wire reset,           // Synchronous reset signal
    input wire [31:0] pc_in,    // Input value for PC (for jumps and branches)
    input wire pc_write,        // Control signal to enable writing to the PC
    input wire pc_inc,          // Control signal to increment the PC
    output reg [31:0] pc_out    // Current value of PC
);

    // On every rising edge of the clock...
    always @(posedge clk) begin
        if (reset) begin
            // If reset is high, set PC to 0
            pc_out <= 32'b0;
        end
        else if (pc_write) begin
            // If pc_write is enabled, load the PC with the input value
            pc_out <= pc_in;
        end
        else if (pc_inc) begin
            // If pc_inc is enabled, increment the PC by 4 (to point to the next instruction)
            pc_out <= pc_out + 32'd4;
        end
    end

endmodule
